From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy
 API
Date: Thu, 6 Nov 2014 14:54:20 -0800
Message-ID: <20141106225420.GA2770@kroah.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com>
 <20141011142156.GC11456@kroah.com>
 <545BF1D1.30304@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55765 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbaKFWyV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Nov 2014 17:54:21 -0500
Content-Disposition: inline
In-Reply-To: <545BF1D1.30304@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

On Fri, Nov 07, 2014 at 12:10:25AM +0200, Vladimir Zapolskiy wrote:
> Hello Greg, Thierry,
> 
> On 11.10.2014 17:21, Greg KH wrote:
> > On Sat, Oct 11, 2014 at 04:46:26PM +0300, Vladimir Zapolskiy wrote:
> >> If PWM device is requested by means of legacy API pwm_request(), its
> >> resources are not freed on module unbind, which may cause an oops on
> >> access, e.g. by reading /sys/kernel/debug/pwm.
> >>
> >> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >>  drivers/video/backlight/pwm_bl.c |    4 ++++
> >>  1 file changed, 4 insertions(+)
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> > for how to do this properly.
> > 
> > </formletter>
> > --
> 
> could you please review the change? I believe it would be nice to have
> oops fix in v3.18.

drivers/video/ is not under my control, so there's nothing I can do
here, sorry...
