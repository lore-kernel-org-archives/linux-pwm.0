From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 RESEND] pwm: Add CLPS711X PWM support
Date: Tue, 25 Feb 2014 16:50:32 +0100
Message-ID: <5211076.9eDkSrDagS@wuerfel>
References: <1393342067-9086-1-git-send-email-shc_work@mail.ru> <5560556.tENBsUTXbt@wuerfel> <1393343277.220396804@f361.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:57487 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaBYP4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 10:56:07 -0500
In-Reply-To: <1393343277.220396804@f361.i.mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>

On Tuesday 25 February 2014 19:47:57 Alexander Shiyan wrote:
> =D0=92=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 25 =D1=84=D0=B5=D0=B2=D1=80=
=D0=B0=D0=BB=D1=8F 2014, 16:33 +01:00 =D0=BE=D1=82 Arnd Bergmann <arnd@=
arndb.de>:
> > On Tuesday 25 February 2014 19:27:47 Alexander Shiyan wrote:
=3D> >=20
> > We really want to avoid wildcards in compatible strings. Can you ca=
ll this
> > "cirrus,cs89712-pwm" to match the first SoC that came with this har=
dware?
> > Obviously if there was some chip before that (I'm not familiar with=
 the
> > model numbers), use that instead.
> >=20
> > You can either list all chips you know that have this in the driver=
,
> > or you use "cirrus,cs89712-pwm" as the fallback, and use the name o=
f
> > the SoC you have as the more specific string.
>=20
> It seems that in this case we will need to modify the compatibility s=
tring
> for other drivers that are already available in the kernel...

Ah, right. I missed the binding for gpio and serial going in.

DT maintainers, any suggestion on how we should proceed here?

AFAICT, clps711x platform support is still work-in-progress, so we don'=
t
have any upstream users to worry about yet, but changing them is still
going to be slightly messy.

	Arnd
