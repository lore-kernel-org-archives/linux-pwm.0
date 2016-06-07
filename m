From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 03/14] pwm: rockchip: Fix period and duty_cycle
 approximation
Date: Tue, 7 Jun 2016 10:25:22 -0700
Message-ID: <20160607172522.GA130037@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160603200326.GA124478@google.com>
 <20160604081955.47393878@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33497 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867AbcFGRZ0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jun 2016 13:25:26 -0400
Received: by mail-pa0-f44.google.com with SMTP id ec8so41949618pac.0
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jun 2016 10:25:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160604081955.47393878@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com

On Sat, Jun 04, 2016 at 08:19:55AM +0200, Boris Brezillon wrote:
> On Fri, 3 Jun 2016 13:03:26 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > On Fri, Jun 03, 2016 at 10:23:01AM +0200, Boris Brezillon wrote:
> > > The current implementation always round down the duty and period
> > > values, while it would be better to round them to the closest integer.  
> > 
> > Agreed. As I noted to you elsewhere, not having this change can cause
> > problems where doing a series of pwm_get_state() / modify /
> > pwm_apply_state() will propagate rounding errors, which will change the
> > period unexpectedly. e.g., I have an expected period of 3.333 us and a
> > clk rate of 112.666667 MHz -- the clock frequency doesn't divide evenly,
> > so the period (stashed in nanoseconds) shrinks when we convert to the
> > register value and back, as follows:
> > 
> >  pwm_apply_state(): register = period * 112666667 / 1000000000;
> >  pwm_get_state(): period = register * 1000000000 / 112666667;
> > 
> > or in other words:
> > 
> >  period = period * 112666667 / 1000000000 * 1000000000 / 112666667;
> > 
> > which yields a sequence like:
> > 
> >  3333 -> 3328
> >  3328 -> 3319
> >  3319 -> 3310
> >  3310 -> 3301
> >  3301 -> 3292
> >  3292 -> ... (etc) ...
> > 
> > With this patch, we'd see instead:
> > 
> >  period = div_round_closest(period * 112666667, 1000000000) * 1000000000 / 112666667;
> > 
> > which yields a stable sequence:
> > 
> >  3333 -> 3337
> >  3337 -> 3337
> >  3337 -> ... (etc) ...
> 
> Woh! Thanks for the detailed explanation. Do you want me to put that in
> a comment explaining why we're using DIV_ROUND_CLOSEST_ULL()?

If you'd like, feel free to add some of this to your v2 description.

Brian
