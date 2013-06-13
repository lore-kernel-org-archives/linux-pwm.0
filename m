Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40706 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833Ab3FMAZP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2013 20:25:15 -0400
From: Kukjin Kim <kgene.kim@samsung.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1444953.LmSrOvSyJG@flatron> <20130612230023.GA9016@quad.lixom.net>
In-reply-to: <20130612230023.GA9016@quad.lixom.net>
Subject: RE: [PATCH 00/15] Final Samsung PWM support cleanup
Date: Thu, 13 Jun 2013 09:25:08 +0900
Message-id: <143801ce67cc$758f54c0$60adfe40$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: 'Olof Johansson' <olof@lixom.net>, 'Tomasz Figa' <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, 'Arnd Bergmann' <arnd@arndb.de>, 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, =?ISO-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>, 'Mark Brown' <broonie@kernel.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>

Olof Johansson wrote:
> 
> On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
> 
> > > Needs testing on other platforms as I could only compile test for
them.
> 
> How/who can help here? WHo has and still cares for other affected
> platforms?
> 
> > > 66 files changed, 627 insertions(+), 1580 deletions(-)
> 
> Nice cleanup.
> 
> > Any comments for this series?
> 
> Yes, above. :) In general looks good -- testing coverage is a bit of a
> concern.
> 
Good news, I'm building up team to support samsung stuff in mainline
including test on boards, you know, I have the most of smdk/ssdk boards :)
But I need some time :(

I looked at reply from Sylwester and Heiko, thanks. Let me pick this series
after their test.

Thanks.

- Kukjin

