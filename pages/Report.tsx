import React from 'react';
import { useNavigate, useParams } from 'react-router-dom';

const Report: React.FC = () => {
  const navigate = useNavigate();
  const { id } = useParams();

  return (
    <div className="flex flex-col min-h-screen bg-background">
      {/* Top Bar */}
      <div className="sticky top-0 z-50 flex items-center bg-white p-4 pb-2 justify-between border-b border-gray-100">
        <button onClick={() => navigate(-1)} className="text-slate-900 flex size-10 shrink-0 items-center justify-start">
          <span className="material-symbols-outlined text-[24px]">arrow_back_ios</span>
        </button>
        <h2 className="text-slate-900 text-lg font-bold leading-tight flex-1 text-center">影像分析报告</h2>
        <button className="flex size-10 items-center justify-end text-slate-900">
          <span className="material-symbols-outlined text-[24px]">more_horiz</span>
        </button>
      </div>

      <main className="flex-1 flex flex-col gap-6 pb-8">
        {/* Image Viewer */}
        <div className="px-4 pt-4">
          <div className="flex flex-col items-stretch justify-start rounded-xl shadow-card bg-white overflow-hidden">
            <div className="relative w-full aspect-[4/3] bg-black group">
              <div 
                className="w-full h-full bg-center bg-no-repeat bg-cover opacity-90" 
                style={{ backgroundImage: 'url("https://lh3.googleusercontent.com/aida-public/AB6AXuDsy1d0N3urq7FCUHs26yAs9NyBgh2keht5t_2uo4FxgvmrY_2G6_MIl5uen0pDLU7LLJRZqi5sX2z0WD8jIJvCZX11Ny9YD-qlvSQKCEGXDA2q05sm-RldROKU3vOLO4wFLyrbZmYNsHRZQPtLq4nUSfTZbNBUyejB8mweqCtlN_flLE3IKx0Zs_9L3JFd5s6ODNjaYLfol0iPTAv6OD-Ltw5Yybt3oLJTKsLCukNvvfun_yvsI3bEw4n0pIHkQC-RYh9tif0ugaM")' }}
              ></div>
              
              {/* Overlay Box */}
              <div className="absolute top-[30%] right-[35%] w-16 h-16 border-2 border-primary/80 rounded-sm shadow-[0_0_10px_rgba(19,127,236,0.5)] animate-pulse flex items-start justify-end p-1">
                <div className="bg-primary text-white text-[10px] font-bold px-1 rounded-sm">98%</div>
              </div>
              <div className="absolute top-[35%] right-[38%] w-12 h-12 bg-primary/20 blur-xl rounded-full"></div>
              
              {/* Image Controls */}
              <div className="absolute bottom-4 right-4 flex gap-2">
                <button className="size-8 rounded-full bg-black/50 backdrop-blur-md flex items-center justify-center text-white hover:bg-primary transition-colors">
                  <span className="material-symbols-outlined text-[18px]">layers</span>
                </button>
                <button className="size-8 rounded-full bg-black/50 backdrop-blur-md flex items-center justify-center text-white hover:bg-primary transition-colors">
                  <span className="material-symbols-outlined text-[18px]">zoom_in</span>
                </button>
              </div>
              
              {/* Tag */}
              <div className="absolute top-4 left-4">
                <span className="bg-black/60 backdrop-blur-md text-white text-xs px-2 py-1 rounded font-medium">轴向视图</span>
              </div>
            </div>
            
            <div className="flex flex-col gap-1 p-4 border-t border-gray-100">
              <div className="flex justify-between items-center">
                <p className="text-slate-900 text-lg font-bold leading-tight">影像编号: #{id || '48291'}</p>
                <p className="text-slate-500 text-xs font-normal">2023年10月24日 • 14:30</p>
              </div>
              <p className="text-slate-500 text-sm font-normal">胸部CT扫描 • 序列 4</p>
            </div>
          </div>
        </div>

        {/* Risk Assessment */}
        <div className="px-4">
          <h2 className="text-slate-900 text-[20px] font-bold leading-tight mb-3">健康风险提示</h2>
          <div className="bg-white rounded-xl p-5 shadow-card border border-gray-100">
            <div className="flex flex-col gap-4">
              <div className="flex justify-between items-end">
                <div className="flex flex-col">
                  <span className="text-slate-500 text-sm font-medium uppercase tracking-wide">风险指数</span>
                  <span className="text-primary text-2xl font-bold mt-1">需重点关注</span>
                </div>
                <span className="text-slate-900 text-3xl font-bold">85<span className="text-sm text-slate-400 font-normal ml-1">/100</span></span>
              </div>
              
              {/* Custom Progress Bar */}
              <div className="relative pt-2">
                <div className="flex justify-between text-xs text-slate-400 mb-2 font-medium">
                  <span>健康</span>
                  <span>关注</span>
                  <span>高风险</span>
                </div>
                <div className="h-3 w-full bg-gray-100 rounded-full overflow-hidden flex">
                  <div className="h-full bg-primary/40 w-[33%] border-r border-white/50"></div>
                  <div className="h-full bg-primary/70 w-[33%] border-r border-white/50"></div>
                  <div className="h-full bg-primary w-[33%] relative">
                    {/* Indicator Line */}
                    <div className="absolute right-[15%] top-0 bottom-0 w-1 bg-white opacity-80"></div>
                  </div>
                </div>
                <div className="mt-3 text-slate-600 text-sm leading-relaxed">
                  AI建议：发现一些值得关注的影像特征，建议您尽快携带影像资料咨询专科医生进行详细评估。
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Findings */}
        <div className="px-4">
          <div className="flex items-center justify-between mb-3">
            <h2 className="text-slate-900 text-[20px] font-bold leading-tight">影像发现</h2>
            <span className="text-primary text-sm font-bold cursor-pointer">查看详情</span>
          </div>
          
          <div className="flex flex-col gap-3">
            {/* Finding 1 */}
            <div className="bg-white rounded-xl p-4 shadow-card border-l-4 border-primary relative">
              <div className="flex justify-between items-start mb-2">
                <div className="flex items-center gap-2">
                  <span className="material-symbols-outlined text-primary text-[20px]">trip_origin</span>
                  <h3 className="text-slate-900 font-bold text-base">肺部结节</h3>
                </div>
                <span className="bg-primary/10 text-primary text-xs font-bold px-2 py-1 rounded-md">置信度 98%</span>
              </div>
              <p className="text-slate-600 text-sm leading-normal mb-3">
                在右肺上部发现一个约6毫米的小结节。建议医生结合临床情况判断。
              </p>
              <div className="flex gap-2">
                <span className="text-[10px] font-medium bg-gray-100 text-slate-500 px-2 py-1 rounded">右肺上叶</span>
                <span className="text-[10px] font-medium bg-gray-100 text-slate-500 px-2 py-1 rounded">实性</span>
                <span className="text-[10px] font-medium bg-gray-100 text-slate-500 px-2 py-1 rounded">6mm</span>
              </div>
            </div>

            {/* Finding 2 */}
            <div className="bg-white rounded-xl p-4 shadow-card border-l-4 border-primary/40 relative">
              <div className="flex justify-between items-start mb-2">
                <div className="flex items-center gap-2">
                  <span className="material-symbols-outlined text-primary/60 text-[20px]">water_drop</span>
                  <h3 className="text-slate-900 font-bold text-base">少量积液</h3>
                </div>
                <span className="bg-gray-100 text-slate-600 text-xs font-bold px-2 py-1 rounded-md">置信度 85%</span>
              </div>
              <p className="text-slate-600 text-sm leading-normal">
                左侧胸腔底部发现少量液体积聚，可能是身体的自然反应，建议咨询医生。
              </p>
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="px-4 mt-2">
          <div className="flex gap-3">
            <button className="flex-1 flex items-center justify-center rounded-xl h-12 border border-primary text-primary bg-white text-sm font-bold active:bg-primary/5 transition-colors">
              <span className="material-symbols-outlined mr-2 text-[20px]">picture_as_pdf</span>
              下载PDF报告
            </button>
            <button className="flex-1 flex items-center justify-center rounded-xl h-12 bg-primary text-white text-sm font-bold shadow-float active:scale-[0.98] transition-transform">
              <span className="material-symbols-outlined mr-2 text-[20px]">save_alt</span>
              保存到手机
            </button>
          </div>
        </div>

        {/* Disclaimer */}
        <div className="px-8 text-center mt-2">
          <p className="text-xs text-orange-600 bg-orange-50 p-2 rounded-lg">
            温馨提示：AI结果仅供参考，请以医生诊断为准
          </p>
        </div>
      </main>
    </div>
  );
};

export default Report;