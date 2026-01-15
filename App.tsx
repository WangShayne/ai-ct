import React from 'react';
import { HashRouter, Routes, Route, useLocation } from 'react-router-dom';
import Home from './pages/Home';
import Report from './pages/Report';
import Files from './pages/Files';
import Profile from './pages/Profile';
import EditProfile from './pages/EditProfile';
import Notifications from './pages/Notifications';
import Feedback from './pages/Feedback';
import BottomNav from './components/BottomNav';

const Layout = ({ children }: { children?: React.ReactNode }) => {
  const location = useLocation();
  // Pages that show the bottom navigation
  const showNav = ['/', '/files', '/profile'].includes(location.pathname);

  return (
    <div className="flex flex-col min-h-screen max-w-md mx-auto bg-background shadow-2xl overflow-hidden relative">
      <div className={`flex-1 overflow-y-auto no-scrollbar ${showNav ? 'pb-24' : ''}`}>
        {children}
      </div>
      {showNav && <BottomNav />}
    </div>
  );
};

const App: React.FC = () => {
  return (
    <HashRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/report/:id" element={<Report />} />
          <Route path="/files" element={<Files />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/profile/edit" element={<EditProfile />} />
          <Route path="/notifications" element={<Notifications />} />
          <Route path="/feedback" element={<Feedback />} />
        </Routes>
      </Layout>
    </HashRouter>
  );
};

export default App;