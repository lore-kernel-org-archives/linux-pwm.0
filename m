From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/4] pwm: lpss: Do not export board infos for
 different PWM types
Date: Fri, 20 Jan 2017 13:15:29 +0200
Message-ID: <20170120111529.GH17297@lahna.fi.intel.com>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-4-andriy.shevchenko@linux.intel.com>
 <20170118111109.GO18989@ulmo.ba.sec>
 <20170118130138.GO2023@lahna.fi.intel.com>
 <20170120110051.GJ3824@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20311 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdATLVB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Jan 2017 06:21:01 -0500
Content-Disposition: inline
In-Reply-To: <20170120110051.GJ3824@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>

On Fri, Jan 20, 2017 at 12:00:51PM +0100, Thierry Reding wrote:
> On Wed, Jan 18, 2017 at 03:01:38PM +0200, Mika Westerberg wrote:
> > On Wed, Jan 18, 2017 at 12:11:09PM +0100, Thierry Reding wrote:
> > > On Mon, Jan 02, 2017 at 11:16:46AM +0200, Andy Shevchenko wrote:
> > > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > 
> > > > The PWM LPSS probe drivers just pass a pointer to the exported board info
> > > > structures to pwm_lpss_probe() based on device PCI or ACPI ID. Since the
> > > > core driver knows everything else except mapping between device ID and the
> > > > type, just pass the type with pwm_lpss_probe() and stop exporting the board
> > > > info structures.
> > > > 
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > ---
> > > >  drivers/pwm/pwm-lpss-pci.c      | 20 ++++++++---------
> > > >  drivers/pwm/pwm-lpss-platform.c | 10 ++++-----
> > > >  drivers/pwm/pwm-lpss.c          | 49 ++++++++++++++++++++++-------------------
> > > >  drivers/pwm/pwm-lpss.h          | 14 +++++-------
> > > >  4 files changed, 44 insertions(+), 49 deletions(-)
> > > 
> > > Is there anything in particular that you think will need this change? It
> > > looks to me more like churn than anything else. Moving away from the per
> > > device struct to describe the particular instance seems to me like
> > > removing flexibility that we might want at some point rather than any
> > > real gain.
> > 
> > It simplifies the probe drivers for one. Since the core driver already
> > handles details of the specific SoC family, I don't think we need the
> > flexibility to be able to pass arbitrary platform data anyway.
> > 
> > No strong feelings, though. I'm fine either way :)
> 
> The current driver uses a strange inversion of the abstraction layer.
> For one we have a "board info" structure that is supposed to describe
> the variants of the hardware that exist. That data is in the core
> driver, for reasons that I no longer remember, and then the PCI and
> ACPI drivers reference those info structures depending on the type of
> hardware they bind to. And worse, we now have to export symbols to
> the PCI and ACPI drivers to make use of them.
> 
> I think this is the wrong way around. The core would ideally be unaware
> of any particular variants and use only the struct pwm_lpss_boardinfo.
> It would then be up to the ACPI and PCI drivers to provide the variants
> they need.
> 
> Perhaps the only reason why the board info structures are in the core
> driver is because the same variant exists as PCI and ACPI devices, so
> putting them in the core removes potential duplication.

Yes, I think that was the reason.

> What I'm saying is that its wrong to have board specific bits in the
> core driver. Duplicating the board info isn't a very attractive
> alternative either, though, so it's not going to be elegant either way.

Agreed.

I think we can drop this patch then and make another that moves the
exported information to both ACPI and PCI drivers (instead of exporting
it from the core driver). That adds some duplication but then keeps the
core driver clean from SoC specific quirks.

Does that work for you?
