Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:37772 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756825Ab3FLXhm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 12 Jun 2013 19:37:42 -0400
From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 00/15] Final Samsung PWM support cleanup
Date: Thu, 13 Jun 2013 01:38:05 +0200
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <20130612230023.GA9016@quad.lixom.net> <1604160.oAKkaEhla1@flatron>
In-Reply-To: <1604160.oAKkaEhla1@flatron>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201306130138.05692.heiko@sntech.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

Am Donnerstag, 13. Juni 2013, 01:13:47 schrieb Tomasz Figa:
> Hi Olof,
> 
> On Wednesday 12 of June 2013 16:00:23 Olof Johansson wrote:
> > On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
> > > > Needs testing on other platforms as I could only compile test for
> > > > them.
> > 
> > How/who can help here? WHo has and still cares for other affected
> > platforms?
> > 
> > > > 66 files changed, 627 insertions(+), 1580 deletions(-)
> 
> I will try to test this on Exynos 4 at work, if I somehow manage to find
> any way to use PWM on our boards (other than already-tested PWM
> clocksource).
> 
> Unfortunately, except S3C6410, I don't have access to other platforms, or
> at least I won't in any reasonable time.
> 
> If I remember correctly, in case of my watchdog support cleanup, Kukjin
> has been able to test it on S5P64x0.
> 
> Heiko and Sylwester used to have some s3c24xx-based boards, not sure if
> they still do and are interested in their support in mainline.
> 
> So all left is S5PC100 (for which I couldn't find anyone who cares) and
> Exynos5.
> 
> > Nice cleanup.
> 
> Thanks.
> 
> > > Any comments for this series?
> > 
> > Yes, above. :) In general looks good -- testing coverage is a bit of a
> > concern.
> 
> Yeah. Unfortunately all I could do was testing on Tiny6410 and compile
> testing on others. I hope we find some really helpful people over here who
> could waste a bit of their precious time for this museum. ;)

I'll try to give it a testrun tomorrow. And my s3c2416 will always be the 
first-love-architecture for me ;-)

Heiko
