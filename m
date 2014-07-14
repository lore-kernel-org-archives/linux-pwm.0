From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers/pwm/Kconfig: Let PWM_CLPS711X depend on HAS_IOMEM
Date: Mon, 14 Jul 2014 18:00:01 +0800
Message-ID: <8FB3DF93-7766-4B0D-9D6B-001861925A9F@gmail.com>
References: <53C27247.2010300@gmail.com> <20140714081843.GK2081@ulmo> <6A7CA9C8-7BC4-44BA-AE71-63BDADFF9023@gmail.com> <20140714093310.GC9755@ulmo>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54503 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbaGNJz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Jul 2014 05:55:56 -0400
In-Reply-To: <20140714093310.GC9755@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Chen Gang <gang.chen.5i5j@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>


=E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
5:33=EF=BC=8CThierry Reding <thierry.reding@gmail.com> =E5=86=99=E9=81=93=
=EF=BC=9A

> On Mon, Jul 14, 2014 at 05:14:05PM +0800, Chen Gang wrote:
>>=20
>> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=884:18=EF=BC=8CThierry Reding <thierry.reding@gmail.com> =E5=86=99=E9=81=
=93=EF=BC=9A
>>=20
>>> On Sun, Jul 13, 2014 at 07:49:27PM +0800, Chen Gang wrote:
>>>> PWM_CLPS711X needs HAS_IOMEM, so let it depend on HAS_IOMEM.
>>>>=20
>>>> The related error (with allmodconfig under score):
>>>>=20
>>>>   MODPOST 1365 modules
>>>> ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undef=
ined!
>>>>=20
>>>>=20
>>>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>>>> ---
>>>> drivers/pwm/Kconfig | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> NAK given the discussion in the other thread.
>>>=20
>>> Thierry
>>=20
>> OK, thanks, and I shall continue focusing the other thread, and send=
 related patch after
>> get conclusion (hope I can finish within this week).
>=20
> Great, thanks for taking care of this.
>=20

That what I should/will do. I start the related thread, so I have duty =
to try
to finish it in time. :-)

Thanks.
=E2=80=94
Chen Gang
Open, share, and attitude like air, water, and life which God blessed.-=
