From: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
Subject: RE: [PATCH] pwm: lpss: remove dependency on clk framework
Date: Wed, 14 May 2014 08:54:51 +0000
Message-ID: <604BF5F4C5D71041942BC7E84ED659EA0B004E18@PGSMSX108.gar.corp.intel.com>
References: <1399624521-26175-1-git-send-email-heikki.krogerus@linux.intel.com>
 <604BF5F4C5D71041942BC7E84ED659EA0B004D2D@PGSMSX108.gar.corp.intel.com>
 <20140514083929.GA12238@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140514083929.GA12238@xps8300>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> 
> Hi,
> 
> On Wed, May 14, 2014 at 07:00:59AM +0000, Chew, Chiau Ee wrote:
> > Heikki,
> > For ACPI mode, the clock rate information for PWM is being setup in the
> acpi_lpss.c layer.
> > Thus, only PCI mode depends on the driver_data to pass in the clock rate
> information.
> 
> The goal with this patch is actually to free acpi_lpss.c from delivering the clock
> for this driver.
> 
> The LPSS PWM does not get it's clock from the LPSS 100Mhz source clock,
> which means we have to have the rate of it's clock hard-coded.
> Since it's already hard coded also in this driver for PCI mode in any case, it
> makes no sense to also have it there.
> 
> So this patch will allow us to cleanup acpi_lpss.c. We can now remove the
> confusing "shared clock" structure where the hard coded rates are held. This
> device is the only one that would need it.
> 

Oh ya...you are right. Sorry about that. I have mixed up the context with other I/O components.

Reviewed-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>

> 
> Thanks,
> 
> --
> heikki
