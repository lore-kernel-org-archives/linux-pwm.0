From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [pwm:for-4.9/drivers 2/9] drivers/pwm/pwm-berlin.c:245:35:
 error: 'struct berlin_pwm_chip' has no member named 'chips'
Date: Tue, 6 Sep 2016 17:09:11 +0800
Message-ID: <20160906170911.466049ae@xhacker>
References: <201609051807.8q1Dh6WZ%fengguang.wu@intel.com>
        <20160906133531.367129f0@xhacker>       <20160906090842.GB15644@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:38836 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752190AbcIFJNc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 05:13:32 -0400
In-Reply-To: <20160906090842.GB15644@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-pwm@vger.kernel.org

On Tue, 6 Sep 2016 11:08:42 +0200 Thierry Reding wrote:

> On Tue, Sep 06, 2016 at 01:35:31PM +0800, Jisheng Zhang wrote:
> > 
> > 
> > On Mon, 5 Sep 2016 18:37:13 +0800 kbuild test robot  wrote:
> >   
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-4.9/drivers
> > > head:   e63ed23775362a6e1a867dc2f75ebbf4e3a8d4d2
> > > commit: fd47f104003c629d0ec6be4c2ead90191c184a23 [2/9] pwm: berlin: Add suspend/resume support
> > > config: arm64-allyesconfig (attached as .config)
> > > compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> > > reproduce:
> > >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout fd47f104003c629d0ec6be4c2ead90191c184a23
> > >         # save the attached .config to linux build tree
> > >         make.cross ARCH=arm64 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    drivers/pwm/pwm-berlin.c: In function 'berlin_pwm_suspend':  
> > > >> drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has no member named 'chips'    
> > >       channel = pwm_get_chip_data(&pwm->chips.pwms[i]);
> > >                                       ^  
> > 
> > 
> > Thanks for information. Below patch can fix it.
> > 
> > Hi Thierry,
> > 
> > a separate fix or amend the commit, which do you prefer?  
> 
> I've squashed the below change into the original patch.
> 
> Thanks,
> Thierry

Thank you so much!
