From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH] pwm:lpss: update pwm setting for Broxton
Date: Thu, 12 Nov 2015 16:50:25 +0200
Message-ID: <20151112145025.GP1509@lahna.fi.intel.com>
References: <1447345684-108039-1-git-send-email-qipeng.zha@intel.com>
 <20151112125236.GD31671@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14592 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384AbbKLOu2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 12 Nov 2015 09:50:28 -0500
Content-Disposition: inline
In-Reply-To: <20151112125236.GD31671@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org

On Thu, Nov 12, 2015 at 01:52:36PM +0100, Thierry Reding wrote:
> On Fri, Nov 13, 2015 at 12:28:04AM +0800, Qipeng Zha wrote:
> > For Broxton PWM controller, base unit is defined as 8bit integer
> > and 14bit fraction, so need to update base unit setting to output
> > wave with right frequency.
> > a) add scaler for each board setting;
> > b) remove validity check of base unit for special board, let pwm
> > user to handle this;
> > 
> > Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> > ---
> >  drivers/pwm/pwm-lpss.c | 20 +++++++++++---------
> >  drivers/pwm/pwm-lpss.h |  1 +
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> > index 2504410..5a907db 100644
> > --- a/drivers/pwm/pwm-lpss.c
> > +++ b/drivers/pwm/pwm-lpss.c
> > @@ -14,6 +14,7 @@
> >   */
> >  
> >  #include <linux/io.h>
> > +#include <linux/time.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/pm_runtime.h>
> > @@ -24,11 +25,9 @@
> >  #define PWM_ENABLE			BIT(31)
> >  #define PWM_SW_UPDATE			BIT(30)
> >  #define PWM_BASE_UNIT_SHIFT		8
> > -#define PWM_BASE_UNIT_MASK		0x00ffff00
> > +#define PWM_BASE_UNIT_MASK		0x3fffff00
> 
> Isn't this going to potentially write reserved bits on non-Broxton
> platforms? Previously the upper 8 bits were masked out, but now only the
> upper 2 bits are masked out. What about the other 6?
> 
> Perhaps it'd be better to parameterize the mask in a way similar to the
> scaler value?

Or call the field "base_unit_bits" which holds 16 for BSW/BYT and 22 for
BXT, and calculate both scaler and mask from that in pwm_lpss_config()?

Actually I think we should make the driver private structure look like
this:

struct pwm_lpss_chip {
        struct pwm_chip chip;
        void __iomem *regs;
        const struct pwm_lpss_boardinfo *info;
};

and then set ->info to point to the platform data in probe().

pwm_lpss_config() can then refer lpwm->info->base_unit_bits and
lpwm->info->clk_rate.

> Also it's unclear to me how critical this is. Initial patches for
> Broxton support were merged into Linus' tree yesterday. Presumably they
> had received some testing before, but nobody can't have noticed or this
> bug wouldn't exist in the patches that were merged. Does this break any
> existing setups and hence should go into v4.4 along with the initial
> Broxton support?

Nobody outside Intel should have Broxtons yet so it should not break any
existing users.
