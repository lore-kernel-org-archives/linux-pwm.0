From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v4 0/2] pwm: lpss: split driver to core and probe drivers
Date: Wed, 20 Aug 2014 18:57:59 +0100
Message-ID: <1408557479.3270.8.camel@acox1-desk.ger.corp.intel.com>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140820101248.GH15414@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7774 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaHTR6d (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 20 Aug 2014 13:58:33 -0400
In-Reply-To: <20140820101248.GH15414@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Wed, 2014-08-20 at 12:12 +0200, Thierry Reding wrote:
> On Tue, Aug 19, 2014 at 07:17:34PM +0300, Andy Shevchenko wrote:
> > This small series makes the architecture of pwm-lpss driver cleaner.
> > 
> > Since v3:
> > - rebased on top of recent linux-next
> > - rebased on top of Alan's patch for Braswell
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
> >  drivers/pwm/pwm-lpss-pci.c      |  65 +++++++++++++++++++
> >  drivers/pwm/pwm-lpss-platform.c |  69 ++++++++++++++++++++
> >  drivers/pwm/pwm-lpss.c          | 136 +++-------------------------------------
> >  drivers/pwm/pwm-lpss.h          |  32 ++++++++++
> >  6 files changed, 198 insertions(+), 127 deletions(-)
> >  create mode 100644 drivers/pwm/pwm-lpss-pci.c
> >  create mode 100644 drivers/pwm/pwm-lpss-platform.c
> >  create mode 100644 drivers/pwm/pwm-lpss.h
> 
> Yea or nay, Alan?

Context ?

