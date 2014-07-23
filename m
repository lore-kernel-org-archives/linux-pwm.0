From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers/pwm/Kconfig: Let PWM_CLPS711X depend on HAS_IOMEM
Date: Wed, 23 Jul 2014 19:51:48 +0800
Message-ID: <53CFA1D4.5060603@gmail.com>
References: <53C27247.2010300@gmail.com> <20140714081843.GK2081@ulmo> <6A7CA9C8-7BC4-44BA-AE71-63BDADFF9023@gmail.com> <20140714093310.GC9755@ulmo> <8FB3DF93-7766-4B0D-9D6B-001861925A9F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65438 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798AbaGWLvy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jul 2014 07:51:54 -0400
In-Reply-To: <8FB3DF93-7766-4B0D-9D6B-001861925A9F@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>

Oh, sorry, after a long discussion, we have to keep current status no
touch -- let individual modules depends on HAS_IOMEM if they need it.

So, this patch is still alive, please help check it, when you have time=
=2E

Thanks.

On 07/14/2014 06:00 PM, Chen Gang wrote:
>=20
> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
5:33=EF=BC=8CThierry Reding <thierry.reding@gmail.com> =E5=86=99=E9=81=93=
=EF=BC=9A
>=20
>> On Mon, Jul 14, 2014 at 05:14:05PM +0800, Chen Gang wrote:
>>>
>>> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=884:18=EF=BC=8CThierry Reding <thierry.reding@gmail.com> =E5=86=99=E9=81=
=93=EF=BC=9A
>>>
>>>> On Sun, Jul 13, 2014 at 07:49:27PM +0800, Chen Gang wrote:
>>>>> PWM_CLPS711X needs HAS_IOMEM, so let it depend on HAS_IOMEM.
>>>>>
>>>>> The related error (with allmodconfig under score):
>>>>>
>>>>>   MODPOST 1365 modules
>>>>> ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] unde=
fined!
>>>>>
>>>>>
>>>>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>>>>> ---
>>>>> drivers/pwm/Kconfig | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> NAK given the discussion in the other thread.
>>>>
>>>> Thierry
>>>
>>> OK, thanks, and I shall continue focusing the other thread, and sen=
d related patch after
>>> get conclusion (hope I can finish within this week).
>>
>> Great, thanks for taking care of this.
>>
>=20
> That what I should/will do. I start the related thread, so I have dut=
y to try
> to finish it in time. :-)
>=20
> Thanks.
> =E2=80=94
> Chen Gang
> Open, share, and attitude like air, water, and life which God blessed=
=2E
>=20

--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
