From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/7] pwm: st: Add new driver for ST's PWM IP
Date: Thu, 19 Jun 2014 12:32:59 +0100
Message-ID: <20140619113259.GO32514@n2100.arm.linux.org.uk>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org> <1403103172-19856-6-git-send-email-lee.jones@linaro.org> <20140618231127.GF26514@mithrandir> <20140619084404.GA26560@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35342 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757273AbaFSLdJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Jun 2014 07:33:09 -0400
Content-Disposition: inline
In-Reply-To: <20140619084404.GA26560@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, srinivas.kandagatla@gmail.com, patrice.chotard@st.com, linux-kernel@vger.kernel.org, ajitpal.singh@st.com, linux-arm-kernel@lists.infradead.org, maxime.coquelin@st.com

On Thu, Jun 19, 2014 at 09:44:04AM +0100, Lee Jones wrote:
> On Thu, 19 Jun 2014, Thierry Reding wrote:
> > On Wed, Jun 18, 2014 at 03:52:51PM +0100, Lee Jones wrote:
> > > +#include <linux/clk.h>
> > > +#include <linux/math64.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/time.h>
> > 
> > These should be sorted alphabetically.
> 
> Really? :)

Yes, as a general rule, for two reasons:

- It helps to reduce conflicts when two people add two different header
  files at a later date (provided they don't ignore the sorting and add
  them both at the end of the list.)

- It helps reduce the chance of having the same include listed twice
  (sometimes silently caused at git merge time) since it means if two
  people independently add the same include in the same place in the
  list, git will cope.  Eg, if one adds an include in one random place
  in the list, and someone else adds the same in another random place in
  the list, the result will be two includes of the same file.  If they're
  sufficiently far apart, git will not flag a conflict.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
