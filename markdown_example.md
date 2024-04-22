# Table example

First example without tablename

| Head 1 | Head 2  | Head 3 | 
|:-------|:-------:|-------:|
| Alpha  | Beta    | Gamma  | 
| Delta  | Epsilon | Zeta   |
| Eta    | Theta   | Iota |

Table: Table content


Another example, with custom tablename


| Head 1 | Head 2  | Head 3 | 
|:-------|:-------:|-------:|
| Alpha  | Beta    | Gamma  | 
| Delta  | Epsilon | Zeta   |
| Eta    | Theta   | Iota |

Table: Table content {tablename=yukitblr}

Another example, with custom colspec


| Head 3 | Head 2  | Head 1 %20 | 
|:-------|:-------:|-------:|
| Alpha %20 | Beta    | Gamma  | 
| Delta   | Epsilon | Zeta   |
| Eta     | Theta   | Iota |

Table: {tablename=yukitblr colspec=X[-1]X[2]X[2]}


Another example but with HTML table in the input Markdown file:

<table class="table table-striped table-hover table-bordered" data-tablename="yukitblr">
<colgroup>
<col style="width: 20%;">
<col style="width: 40%">
<col style="width: 30%">
</colgroup>
<thead>
<tr class="header">
<th align="left">Head 1</th>
<th align="center">Head 2</th>
<th align="right">Head 3</th>
</tr>
</thead>
<tbody class="table-group-divider">
<tr class="odd">
    <td>Alpha</td>
    <td>Beta</td>
    <td>Gamma</td>
</tr>
<tr>
    <td>Delta</td>
    <td>Epsilon</td>
    <td>Zeta</td>
</tr>
<tr>
    <td>Eta</td>
    <td>Theta</td>
    <td>Iota</td>
</tr>
</tbody>
</table>

TODO: There are things in the HTML table that doesn't work:

- Alignments

- Custom features per-cell