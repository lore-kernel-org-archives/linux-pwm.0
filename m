From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] pwm: lpss: Add support for multiple PWMs
Date: Fri, 6 Nov 2015 15:36:02 +0200
Message-ID: <20151106133602.GY1509@lahna.fi.intel.com>
References: <1445349187-114759-1-git-send-email-mika.westerberg@linux.intel.com>
 <20151106132953.GA31797@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151106132953.GA31797@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Qipeng Zha <qipeng.zha@intel.com>, Huiquan Zhong <huiquan.zhong@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Nov 06, 2015 at 02:29:53PM +0100, Thierry Reding wrote:
> On Tue, Oct 20, 2015 at 04:53:05PM +0300, Mika Westerberg wrote:
> > New Intel SoCs such as Broxton will have four PWMs per PCI (or ACPI)
> > device. Each PWM has 1k of register space allocated from the parent device.
> > Add support for this.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-lpss.c | 48 +++++++++++++++++++++++++++---------------------
> >  drivers/pwm/pwm-lpss.h |  1 +
> >  2 files changed, 28 insertions(+), 21 deletions(-)
> 
> Applied all three patches, with a minor cleanup, see below.
> 
> > diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> > index aa041bb1b67d..ef2419f47c57 100644
> > --- a/drivers/pwm/pwm-lpss.h
> > +++ b/drivers/pwm/pwm-lpss.h
> > @@ -20,6 +20,7 @@ struct pwm_lpss_chip;
> >  
> >  struct pwm_lpss_boardinfo {
> >  	unsigned long clk_rate;
> > +	size_t npwm;
> >  };
> 
> I changed the type of npwm to unsigned int to match the definition of
> the pwm_chip.npwm field.

Thanks!
