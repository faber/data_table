Makin Tables From Data
======================


Example template:


    %table{table.html_opts}
      %thead
        %tr
          -columns.each do |column|
            %th=link_to column.label, '#'
    
      %tbody
        -records.each do |record|
          %tr
            -columns.each do |column|
              %td{column.html_opts}
                =column.value(record)
