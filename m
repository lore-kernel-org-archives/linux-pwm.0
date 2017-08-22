From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 2/2] pwm: add ZTE ZX PWM device driver
Date: Tue, 22 Aug 2017 16:23:42 +0800
Message-ID: <20170822082341.GA3685@dragon>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
 <1501143817-15843-3-git-send-email-shawnguo@kernel.org>
 <20170821060352.GC18996@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbdHVIXu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Aug 2017 04:23:50 -0400
Content-Disposition: inline
In-Reply-To: <20170821060352.GC18996@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

On Mon, Aug 21, 2017 at 08:03:52AM +0200, Thierry Reding wrote:
> On Thu, Jul 27, 2017 at 04:23:37PM +0800, Shawn Guo wrote:
> > From: Shawn Guo <shawn.guo@linaro.org>
> > 
> > It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
> > supports 4 devices with polarity configuration.
> > 
> > The driver has been tested with pwm-regulator support to scale core
> > voltage via cpufreq.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/pwm/Kconfig  |   9 ++
> >  drivers/pwm/Makefile |   1 +
> >  drivers/pwm/pwm-zx.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 280 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-zx.c
> 
> I've applied this, with some bikeshedding applied. See below for the
> changes I made.

Thanks, Thierry.  I appreciate the effort for those changes, and I'm
totally fine with them.

Shawn
