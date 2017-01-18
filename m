From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/4] pwm: lpss: Do not export board infos for
 different PWM types
Date: Wed, 18 Jan 2017 15:01:38 +0200
Message-ID: <20170118130138.GO2023@lahna.fi.intel.com>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-4-andriy.shevchenko@linux.intel.com>
 <20170118111109.GO18989@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9561 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754635AbdARNEA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Jan 2017 08:04:00 -0500
Content-Disposition: inline
In-Reply-To: <20170118111109.GO18989@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>

On Wed, Jan 18, 2017 at 12:11:09PM +0100, Thierry Reding wrote:
> On Mon, Jan 02, 2017 at 11:16:46AM +0200, Andy Shevchenko wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > The PWM LPSS probe drivers just pass a pointer to the exported board info
> > structures to pwm_lpss_probe() based on device PCI or ACPI ID. Since the
> > core driver knows everything else except mapping between device ID and the
> > type, just pass the type with pwm_lpss_probe() and stop exporting the board
> > info structures.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pwm/pwm-lpss-pci.c      | 20 ++++++++---------
> >  drivers/pwm/pwm-lpss-platform.c | 10 ++++-----
> >  drivers/pwm/pwm-lpss.c          | 49 ++++++++++++++++++++++-------------------
> >  drivers/pwm/pwm-lpss.h          | 14 +++++-------
> >  4 files changed, 44 insertions(+), 49 deletions(-)
> 
> Is there anything in particular that you think will need this change? It
> looks to me more like churn than anything else. Moving away from the per
> device struct to describe the particular instance seems to me like
> removing flexibility that we might want at some point rather than any
> real gain.

It simplifies the probe drivers for one. Since the core driver already
handles details of the specific SoC family, I don't think we need the
flexibility to be able to pass arbitrary platform data anyway.

No strong feelings, though. I'm fine either way :)
