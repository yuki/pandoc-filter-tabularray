function get_rows_data(rows)
  local data = ''
  for j, row in ipairs(rows) do
    for k, cell in ipairs(row.cells) do
      data = data .. pandoc.utils.stringify(cell.contents)
      if (k == #row.cells) then
        data = data .. ' \\\\ \n'
      else
        data = data .. ' & '
      end
    end
  end
  return data
end

function generate_tabularray(tbl)
  local table_class = 'longtblr'

  if (tbl.attributes['tablename'] ~= nil) then
    table_class = tbl.attributes['tablename']
  end

  local caption = pandoc.utils.stringify(tbl.caption.long)
  local caption_content = caption:match("{(.-)}")
  if caption_content then
    caption = caption:gsub("{.-}", "")
  end

  if caption_content then
    local new_table_class = caption_content:match("=(.*)")
    if new_table_class then
      table_class = new_table_class
    end
  end

  -- COLSPECS
  local col_specs = tbl.colspecs
  local col_specs_latex = ''
  for i, col_spec in ipairs(col_specs) do
    local align = col_spec[1]
    local width = col_spec[2]

    col_specs_latex = col_specs_latex .. 'X['

    if width ~= 0 and width ~= nil then
      col_specs_latex = col_specs_latex .. width..'\\linewidth,'
    end

    if align == 'AlignLeft' then
      col_specs_latex = col_specs_latex .. 'l'
    elseif align == 'AlignRight' then
      col_specs_latex = col_specs_latex .. 'r'
    else -- elseif align == 'AlignCenter' then
      col_specs_latex = col_specs_latex .. 'c'
    end

    col_specs_latex = col_specs_latex .. ']'
  end

  local result = pandoc.List:new{pandoc.RawBlock("latex", '\\begin{'..table_class..'}[caption={'..caption..'}]{'..col_specs_latex..'}')}

  -- HEADER
  local header_latex = get_rows_data(tbl.head.rows)
  result = result .. pandoc.List:new{pandoc.RawBlock("latex", header_latex)}

  -- ROWS
  local rows_latex = ''
  for j, tablebody in ipairs(tbl.bodies) do
    rows_latex = get_rows_data(tablebody.body)
  end
  result = result .. pandoc.List:new{pandoc.RawBlock("latex", rows_latex)}

  -- FOOTER
  local footer_latex = get_rows_data(tbl.foot.rows)
  result = result .. pandoc.List:new{pandoc.RawBlock("latex", footer_latex)}

  result = result .. pandoc.List:new{pandoc.RawBlock("latex", '\\end{'..table_class..'}')}
  return result
end



if FORMAT:match 'latex' then

  function Table (tbl)
    return generate_tabularray(tbl)
  end

  function RawBlock(raw)    
    if raw.format:match 'html' and raw.text:match '%<table' then
      blocks = pandoc.read(raw.text, raw.format).blocks
      for i, block in ipairs(blocks) do
        if block.t == 'Table' then
          return generate_tabularray(block)
        end
      end
    end
  end

end

-- when parsing to HTML
if FORMAT:match 'html' then

  function Table(tbl)
    local table_class = 'longtblr'
    local caption = pandoc.utils.stringify(tbl.caption.long)
    local caption_content = caption:match("{(.-)}")

    if caption_content then
      tbl.caption.long = caption:gsub("{.-}", "")
      local new_table_class = caption_content:match("=(.*)")
      if new_table_class then
        table_class = new_table_class
      end
    end

    tbl.attributes['tablename'] = table_class

    return tbl
  end

end