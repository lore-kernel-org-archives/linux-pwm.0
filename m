From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/2] pwm: lpss: split driver to core and probe drivers
Date: Tue, 29 Jul 2014 11:57:11 +0300
Message-ID: <1406624231.8530.55.camel@smile.fi.intel.com>
References: <1406559792-30652-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140728152954.GA10126@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56491 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbaG2I5O (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 29 Jul 2014 04:57:14 -0400
In-Reply-To: <20140728152954.GA10126@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On Mon, 2014-07-28 at 17:29 +0200, Thierry Reding wrote:
> On Mon, Jul 28, 2014 at 06:03:10PM +0300, Andy Shevchenko wrote:
> > This small series makes the architecture of pwm-lpss driver cleaner.
> > 
> > Since v2:
> > - fix one more typo in Kconfig (tested with one line removed in my config now)
> > 
> > Since v1:
> > - hide struct definition in the core part
> > - rename pwm-lpss-plat to pwm-lpss-platform
> > - fix Kconfig dependencies and other typos
> > - add Mika's Reviewed-by tag
> > - fix spelling in the commit messages
> > 
> > Andy Shevchenko (2):
> >   pwm: lpss: properly split driver to parts
> >   pwm: lpss: pci: move to use pcim_enable_device()
> > 
> >  drivers/pwm/Kconfig             |  21 ++++++-
> >  drivers/pwm/Makefile            |   2 +
> >  drivers/pwm/pwm-lpss-pci.c      |  68 ++++++++++++++++++++++
> >  drivers/pwm/pwm-lpss-platform.c |  61 ++++++++++++++++++++
> >  drivers/pwm/pwm-lpss.c          | 125 ++--------------------------------------
> >  drivers/pwm/pwm-lpss.h          |  29 ++++++++++
> >  6 files changed, 186 insertions(+), 120 deletions(-)
> >  create mode 100644 drivers/pwm/pwm-lpss-pci.c
> >  create mode 100644 drivers/pwm/pwm-lpss-platform.c
> >  create mode 100644 drivers/pwm/pwm-lpss.h
> 
> I'd like an Acked-by from Alan on this since he had strong objections
> when I requested exactly this a while back.

Meanwhile he is in Cc list, could you share the link to the previous
discussion?

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

