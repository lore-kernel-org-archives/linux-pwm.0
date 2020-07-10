From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] Revert "pwm: jz4740: Enhance precision in calculation of duty cycle"
Date: Fri, 10 Jul 2020 12:46:47 +0200
Message-ID: <3FFAD80E-02F0-4522-9EB5-C201A36CADC8@goldelico.com>
References: <9335b924318fb36a882d5b46e8e9f2a10bb24daa.1594365885.git.hns@goldelico.com> <20200710101827.rkaxju7msco4mez7@pengutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:35668 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJKrA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jul 2020 06:47:00 -0400
In-Reply-To: <20200710101827.rkaxju7msco4mez7@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, linux-mips@vger.kernel.org, tsbogend@alpha.franken.de, stable@vger.kernel.org


> Am 10.07.2020 um 12:18 schrieb Uwe Kleine-K=F6nig =
<u.kleine-koenig@pengutronix.de>:
>=20
> On Fri, Jul 10, 2020 at 09:24:45AM +0200, H. Nikolaus Schaller wrote:
>> This reverts commit a6030d71e62d3e0e270bf3b7fb48d32a636732db.
>>=20
>> which was applied to v5.4.49. This ends in a compile issue:
>>=20
>>  CC      drivers/pwm/pwm-jz4740.o - due to target missing
>> drivers/pwm/pwm-jz4740.c: In function 'jz4740_pwm_apply':
>> drivers/pwm/pwm-jz4740.c:111:28: error: 'rate' undeclared (first use =
in this function)
>>  tmp =3D (unsigned long long)rate * state->duty_cycle;
>>                            ^
>> drivers/pwm/pwm-jz4740.c:111:28: note: each undeclared identifier is =
reported only once for each function it appears in
>> make[4]: *** [drivers/pwm/pwm-jz4740.o] Error 1
>>=20
>> v5.5 and later include the required additional patches to define
>> the rate variable.
>=20
> So 9017dc4fbd59 ("pwm: jz4740: Enhance precision in calculation of =
duty
> cycle") which is in v5.8-rc1 was backported to stable:
>=20
> 	v5.4.49 (as commit a6030d71e62d3e0e270bf3b7fb48d32a636732db)
> 	v5.7.5 (as commit e0e71bb7852142a18fb829da419013bb6da9ed3f)
>=20
> However 9017dc4fbd59 depends on
>=20
> 	ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")
>=20
> (which in mainline comes before 9017dc4fbd59 as it's included in
> v5.7-rc1).
>=20
> As ce1f9cece057 was not backported to v5.4.x, this must either be =
done, or
> we need to patch that. Will reply with a suggested change.

That is what I did suspect that some other patch this one depends on
was not backported.

What the better strategy (backport missing parts or revert) depends
on how easy it is to backport to v5.4.y.

I am happy with either solution. It is just simpler for me to post
my workaround for the compile issue.

>=20
> In v5.7.x there is no problem.

In v5.5 and v5.6 there is also no problem. Just v5.4 starting with =
v5.4.49.

BR and thanks,
Nikolaus
