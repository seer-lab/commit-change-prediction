full = '/home/joseph/source_code/heron-thesis/'
output_file = "#{full}appendix_content.tex"
path = "#{full}src/images"

latex_image_path = 'images'

method = 'rf'
test = 'test_3'

out = File.open(output_file, 'w')

def create_figure(f, path, caption, label)

    f.puts "% Figure for #{caption}"
    f.puts '\begin{figure}[!t]'
    f.puts '\centering'
    f.puts "\\includegraphics[width=0.8\\textwidth]{#{path}}"
    f.puts "\\caption{#{caption}}"
    f.puts "\\label{fig:#{label}}"
    f.puts '\end{figure}'
    f.puts ''

end

caption_start = ''

if test == 'test_1'
    caption_start = '\gls{swr} for'
elsif test == 'test_3'
    caption_start = 'Feature for'
end

i = 0

projects = Array.new

Dir.glob("#{path}/#{method}/#{test}/*_sample_range.png") do |file|
    # Create a figure for that program and if the importance exists create the figure for that too

    file_name = File.basename(file)

    project_name = file_name.scan(/(.+?)_sample_range.png/)[0][0]

    projects << {:file_name => file_name, :project_name => project_name}


end

projects = projects.sort_by do |project|
    project[:project_name].downcase
end

projects.each do |project|

    create_figure(out, "#{latex_image_path}/#{method}/#{test}/#{project[:file_name]}", "#{caption_start} #{project[:project_name]} using \\gls{#{method}}", "#{test}_#{project[:project_name]}_#{method}")

    if test == 'test_1' && method == 'rf' && File.exists?("#{path}/#{method}/#{test}/#{project[:project_name]}_importance.png")
        create_figure(out, "#{latex_image_path}/#{method}/#{test}/#{project[:project_name]}_importance.png", "Feature Importance #{caption_start} #{project[:project_name]} using \\gls{#{method}}", "#{test}_#{project[:project_name]}_#{method}_importance")
    end

    if i % 10 == 0
        out.puts '\clearpage'
    end

    i += 1

end


=begin
\begin{figure}[!t]
    \centering

        \includegraphics[width=0.8\textwidth]{images/svm/test_3/acra_sample_range}
        \caption{Feature for acra using \gls{svm}}
        \label{fig:test_3_acra_svm}
\end{figure}
=end

=begin

        \caption{\gls{swr} for fresco using \gls{svm}}
        \label{fig:test_1_fresco_svm}
=end
