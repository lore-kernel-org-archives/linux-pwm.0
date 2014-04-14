From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm_lpss: Add support for PCI devices
Date: Mon, 14 Apr 2014 11:59:11 +0300
Message-ID: <20140414085911.GL19349@intel.com>
References: <1397311131-13371-1-git-send-email-chiau.ee.chew@intel.com>
 <534A67B8.80600@linux.intel.com>
 <604BF5F4C5D71041942BC7E84ED659EA01570A7A@PGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60580 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbaDNIvg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 14 Apr 2014 04:51:36 -0400
Content-Disposition: inline
In-Reply-To: <604BF5F4C5D71041942BC7E84ED659EA01570A7A@PGSMSX103.gar.corp.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
Cc: "Li, Aubrey" <aubrey.li@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Alan Cox <alan@linux.intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 14, 2014 at 02:05:25AM +0000, Chew, Chiau Ee wrote:
> > >  MODULE_DESCRIPTION("PWM driver for Intel LPSS");
> > >MODULE_AUTHOR("Mika
> > > Westerberg <mika.westerberg@linux.intel.com>");
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_ALIAS("platform:pwm-lpss");
> > 
> > Looks a good idea to combine pci and acpi driver together.
> > Since pci driver is added, here the alias need to be refined.
> > Others look good.
> > 
> > Thanks,
> > -Aubrey
> 
> Ok. I will change it to MODULE_ALIAS("pci/platform:pwm-lpss");

Hmm, does that really work like that?

For PCI and ACPI you already have tables with MODULE_DEVICE_TABLE().

For pure platform driver (which is probably not going to be used) you nede
to have MODULE_ALIAS() if you want modprobe to load it automagically.
