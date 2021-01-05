cd '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/matlab';

Blast=pfp_importblastp('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/blastp.out');

ont = pfp_ontbuild('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/ontology/go_cafa3.obo');

BPO=ont{1,1}
CCO=ont{1,2}
MFO=ont{1,3}

oa_bp = pfp_oabuild(BPO, '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/groundtruth/leafonly_BPO.txt');
oa_cc = pfp_oabuild(CCO, '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/groundtruth/leafonly_CCO.txt');
oa_mf = pfp_oabuild(MFO, '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/groundtruth/leafonly_MFO.txt');

benchmark_bpo_type1=pfp_loaditem('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/bpo_all_type1.txt', 'char');
benchmark_bpo_type2=pfp_loaditem('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/bpo_all_type2.txt', 'char');
benchmark_cco_type1=pfp_loaditem('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/cco_all_type1.txt', 'char');
benchmark_cco_type2=pfp_loaditem('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/cco_all_type2.txt', 'char');
benchmark_mfo_type1=pfp_loaditem('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/mfo_all_type1.txt', 'char');
benchmark_mfo_type2=pfp_loaditem('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/mfo_all_type2.txt', 'char');

% merge the benchmarks together
benchmark_bpo = union(benchmark_bpo_type1, benchmark_bpo_type2);
benchmark_mfo = union(benchmark_cco_type1, benchmark_cco_type2);
benchmark_cco = union(benchmark_mfo_type1, benchmark_mfo_type2);

bpoa_mat.oa = oa_bp;
ccoa_mat.oa = oa_cc;
mfoa_mat.oa = oa_mf;

bpoa_mat.eia = pfp_eia(BPO.DAG, oa_bp.annotation);
ccoa_mat.eia = pfp_eia(CCO.DAG, oa_cc.annotation);
mfoa_mat.eia = pfp_eia(MFO.DAG, oa_mf.annotation);

save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/groundtruth/bpoa.mat", '-struct', 'bpoa_mat');
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/groundtruth/ccoa.mat", '-struct', 'ccoa_mat');
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/groundtruth/mfoa.mat", '-struct', 'mfoa_mat');

pred_bp = cafa_import('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/BonelloFunFam_ff_all_go.txt', ont{1,1}, true);
pred_cc = cafa_import('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/BonelloFunFam_ff_all_go.txt', ont{1,2}, true);
pred_mf = cafa_import('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/BonelloFunFam_ff_all_go.txt', ont{1,3}, true);


blastp_bpo_type1=pfp_blast(benchmark_bpo_type1, Blast, oa_bp);
blastp_bpo_type2=pfp_blast(benchmark_bpo_type2, Blast, oa_bp);
blastp_cco_type1=pfp_blast(benchmark_cco_type1, Blast, oa_cc);
blastp_cco_type2=pfp_blast(benchmark_cco_type2, Blast, oa_cc);
blastp_mfo_type1=pfp_blast(benchmark_mfo_type1, Blast, oa_mf);
blastp_mfo_type2=pfp_blast(benchmark_mfo_type2, Blast, oa_mf);

blastp_bpo=pfp_blast(benchmark_bpo, Blast, oa_bp);
blastp_cco=pfp_blast(benchmark_cco, Blast, oa_cc);
blastp_mfo=pfp_blast(benchmark_mfo, Blast, oa_mf);

pred=blastp_bpo;
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/baselines/bpo/BB4S.mat", 'pred');
pred=blastp_cco;
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/baselines/cco/BB4S.mat", 'pred');
pred=blastp_mfo;
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/baselines/mfo/BB4S.mat", 'pred');

naive_bpo_type1=pfp_naive(benchmark_bpo_type1, oa_bp);
naive_bpo_type2=pfp_naive(benchmark_bpo_type2, oa_bp);
naive_cco_type1=pfp_naive(benchmark_cco_type1, oa_cc);
naive_cco_type2=pfp_naive(benchmark_cco_type2, oa_cc);
naive_mfo_type1=pfp_naive(benchmark_mfo_type1, oa_mf);
naive_mfo_type2=pfp_naive(benchmark_mfo_type2, oa_mf);

naive_bpo=pfp_naive(benchmark_bpo, oa_bp);
naive_cco=pfp_naive(benchmark_cco, oa_cc);
naive_mfo=pfp_naive(benchmark_mfo, oa_mf);

pred=naive_bpo;
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/baselines/bpo/BN4S.mat", 'pred');
pred=naive_cco;
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/baselines/cco/BN4S.mat", 'pred');
pred=naive_mfo;
save("/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/baselines/mfo/BN4S.mat", 'pred');

fmax_bpo_type1=pfp_seqmetric(benchmark_bpo_type1, pred_bp, oa_bp, 'fmax');
smin_bpo_type1=pfp_seqmetric(benchmark_bpo_type1, pred_bp, oa_bp, 'smin', 'w', []);
fmax_bpo_type2=pfp_seqmetric(benchmark_bpo_type2, pred_bp, oa_bp, 'fmax');
smin_bpo_type2=pfp_seqmetric(benchmark_bpo_type2, pred_bp, oa_bp, 'smin', 'w', []);
fmax_cco_type1=pfp_seqmetric(benchmark_cco_type1, pred_cc, oa_cc, 'fmax');
smin_cco_type1=pfp_seqmetric(benchmark_cco_type1, pred_cc, oa_cc, 'smin', 'w', []);
fmax_cco_type2=pfp_seqmetric(benchmark_cco_type2, pred_cc, oa_cc, 'fmax');
smin_cco_type2=pfp_seqmetric(benchmark_cco_type2, pred_cc, oa_cc, 'smin', 'w', []);
fmax_mfo_type1=pfp_seqmetric(benchmark_mfo_type1, pred_mf, oa_mf, 'fmax');
smin_mfo_type1=pfp_seqmetric(benchmark_mfo_type1, pred_mf, oa_mf, 'smin', 'w', []);
fmax_mfo_type2=pfp_seqmetric(benchmark_mfo_type2, pred_mf, oa_mf, 'fmax');
smin_mfo_type2=pfp_seqmetric(benchmark_mfo_type2, pred_mf, oa_mf, 'smin', 'w', []);

cm_bpo_type1 = pfp_seqcm(benchmark_bpo_type1,pred_bp, oa_bp); 
cm_bpo_type2 = pfp_seqcm(benchmark_bpo_type2,pred_bp, oa_bp); 
cm_cco_type1 = pfp_seqcm(benchmark_cco_type1,pred_cc, oa_cc); 
cm_cco_type2 = pfp_seqcm(benchmark_cco_type2,pred_cc, oa_cc); 
cm_mfo_type1 = pfp_seqcm(benchmark_mfo_type1,pred_mf, oa_mf); 
cm_mfo_type2 = pfp_seqcm(benchmark_mfo_type2,pred_mf, oa_mf); 

seq_pr_bpo_type1 = pfp_convcmstruct(cm_bpo_type1, 'pr');
seq_pr_bpo_type2 = pfp_convcmstruct(cm_bpo_type2, 'pr');
seq_pr_cco_type1 = pfp_convcmstruct(cm_cco_type1, 'pr');
seq_pr_cco_type2 = pfp_convcmstruct(cm_cco_type2, 'pr');
seq_pr_mfo_type1 = pfp_convcmstruct(cm_mfo_type1, 'pr');
seq_pr_mfo_type2 = pfp_convcmstruct(cm_mfo_type2, 'pr');

cafa3repo='/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2';
predpath='/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics';
eval_res=strcat(predpath, '/evaluation/mfo_all_type1_mode1/mfo_all_type1_mode1');
config=strcat(predpath, '/config/cafa3-mfo.job');
register=strcat(predpath, '/config/register.tab');

% cafa_setup('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics');
cafa_setup(cafa3repo, predpath);


%cafa_driver_filter('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/consolidated', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/bpo_all_type1.txt');
%cafa_driver_filter('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/consolidated', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/bpo_all_type2.txt');
%cafa_driver_filter('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/consolidated', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/cco_all_type1.txt');
%cafa_driver_filter('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/consolidated', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/cco_all_type2.txt');
%cafa_driver_filter('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/consolidated', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/mfo_all_type1.txt');
%cafa_driver_filter('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/consolidated', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/benchmark/lists/mfo_all_type2.txt');

cafa_driver_filter(strcat(predpath,'/consolidated'), strcat(predpath,'/filtered'), strcat(cafa3repo,'/benchmark/lists/mfo_all_typex.txt'));

% cafa_driver_import('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/prediction/bpo', BPO);
% cafa_driver_import('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/prediction/cco', CCO);
% cafa_driver_import('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/filtered', '/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/prediction/mfo', MFO);

% load('../ontology/MFO.mat');

cafa_driver_import(strcat(predpath,'/filtered'), strcat(predpath,'/prediction/mfo'), MFO);

%cafa_driver_preeval('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/config/cafa3-mfo.job');
%cafa_driver_eval('/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/config/cafa3-mfo.job');

cafa_driver_preeval(config);
cafa_driver_eval(config);

% cafa_driver_result('/mnt/DataDrive/predictions/tmp/predictions/20201217161407/metrics/evaluation/mfo', '/mnt/DataDrive/Data/CAFA2/Supplementary_data/code/yuxjiang/CAFA2/config/register.tab', 'BN4S', 'BB4S', 'all');

cafa_driver_result(eval_res, register, 'BN4S', 'BB4S', 'all'); 