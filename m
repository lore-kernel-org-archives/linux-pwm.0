From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v4 0/2] pwm: lpss: split driver to core and probe drivers
Date: Thu, 21 Aug 2014 15:20:56 +0100
Message-ID: <1408630856.3270.33.camel@acox1-desk.ger.corp.intel.com>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140820101248.GH15414@ulmo>
	 <1408557479.3270.8.camel@acox1-desk.ger.corp.intel.com>
	 <20140821064305.GD4486@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47282 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018AbaHUOVF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 21 Aug 2014 10:21:05 -0400
In-Reply-To: <20140821064305.GD4486@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Thu, 2014-08-21 at 08:43 +0200, Thierry Reding wrote:
> On Wed, Aug 20, 2014 at 06:57:59PM +0100, Alan Cox wrote:
> > On Wed, 2014-08-20 at 12:12 +0200, Thierry Reding wrote:
> > > On Tue, Aug 19, 2014 at 07:17:34PM +0300, Andy Shevchenko wrote:
> > > > This small series makes the architecture of pwm-lpss driver cleaner.
> > > > 
> > > > Since v3:
> > > > - rebased on top of recent linux-next
> > > > - rebased on top of Alan's patch for Braswell
> > > > 
> > > > Since v2:
> > > > - fix one more typo in Kconfig (tested with one line removed in my config now)
> > > > 
> > > > Since v1:
> > > > - hide struct definition in the core part
> > > > - rename pwm-lpss-plat to pwm-lpss-platform
> > > > - fix Kconfig dependencies and other typos
> > > > - add Mika's Reviewed-by tag
> > > > - fix spelling in the commit messages
> > > > 
> > > > Andy Shevchenko (2):
> > > >   pwm: lpss: properly split driver to parts
> > > >   pwm: lpss: pci: move to use pcim_enable_device()
> > > > 
> > > >  drivers/pwm/Kconfig             |  21 ++++++-
> > > >  drivers/pwm/Makefile            |   2 +
> > > >  drivers/pwm/pwm-lpss-pci.c      |  65 +++++++++++++++++++
> > > >  drivers/pwm/pwm-lpss-platform.c |  69 ++++++++++++++++++++
> > > >  drivers/pwm/pwm-lpss.c          | 136 +++-------------------------------------
> > > >  drivers/pwm/pwm-lpss.h          |  32 ++++++++++
> > > >  6 files changed, 198 insertions(+), 127 deletions(-)
> > > >  create mode 100644 drivers/pwm/pwm-lpss-pci.c
> > > >  create mode 100644 drivers/pwm/pwm-lpss-platform.c
> > > >  create mode 100644 drivers/pwm/pwm-lpss.h
> > > 
> > > Yea or nay, Alan?
> > 
> > Context ?
> 
> Back when the LPSS PWM driver was first submitted I suggested that it
> could be split up in this way (core + PCI and ACPI/platform drivers).
> You had objections to doing that. Now Andy's doing exactly that, so I
> would like your Acked-by (or NAK) on this change.

I think Andy proved you were right 8)

Ack from me

Alan


