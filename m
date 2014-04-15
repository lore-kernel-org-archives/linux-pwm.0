From: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
Subject: RE: [PATCH] pwm_lpss: Add support for PCI devices
Date: Tue, 15 Apr 2014 08:59:31 +0000
Message-ID: <604BF5F4C5D71041942BC7E84ED659EA01570E4F@PGSMSX103.gar.corp.intel.com>
References: <1397311131-13371-1-git-send-email-chiau.ee.chew@intel.com>
 <534A67B8.80600@linux.intel.com>
 <604BF5F4C5D71041942BC7E84ED659EA01570A7A@PGSMSX103.gar.corp.intel.com>
 <20140414085911.GL19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140414085911.GL19349@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Li, Aubrey" <aubrey.li@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Alan Cox <alan@linux.intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> On Mon, Apr 14, 2014 at 02:05:25AM +0000, Chew, Chiau Ee wrote:
> > > >  MODULE_DESCRIPTION("PWM driver for Intel LPSS");
> > > >MODULE_AUTHOR("Mika  Westerberg
> > > ><mika.westerberg@linux.intel.com>");
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_ALIAS("platform:pwm-lpss");
> > >
> > > Looks a good idea to combine pci and acpi driver together.
> > > Since pci driver is added, here the alias need to be refined.
> > > Others look good.
> > >
> > > Thanks,
> > > -Aubrey
> >
> > Ok. I will change it to MODULE_ALIAS("pci/platform:pwm-lpss");
> 
> Hmm, does that really work like that?
> 
> For PCI and ACPI you already have tables with MODULE_DEVICE_TABLE().
> 
> For pure platform driver (which is probably not going to be used) you nede to
> have MODULE_ALIAS() if you want modprobe to load it automagically.

Ok, looks like MODULE_ALIAS() is a redundant. I will remove it.
