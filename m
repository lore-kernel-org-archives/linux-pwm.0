From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers/pwm/Kconfig: Let PWM_CLPS711X depend on HAS_IOMEM
Date: Mon, 14 Jul 2014 17:14:05 +0800
Message-ID: <6A7CA9C8-7BC4-44BA-AE71-63BDADFF9023@gmail.com>
References: <53C27247.2010300@gmail.com> <20140714081843.GK2081@ulmo>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49784 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaGNJKB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Jul 2014 05:10:01 -0400
In-Reply-To: <20140714081843.GK2081@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Chen Gang <gang.chen.5i5j@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Liqin Chen <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>


=E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
4:18=EF=BC=8CThierry Reding <thierry.reding@gmail.com> =E5=86=99=E9=81=93=
=EF=BC=9A

> On Sun, Jul 13, 2014 at 07:49:27PM +0800, Chen Gang wrote:
>> PWM_CLPS711X needs HAS_IOMEM, so let it depend on HAS_IOMEM.
>>=20
>> The related error (with allmodconfig under score):
>>=20
>>    MODPOST 1365 modules
>>  ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefi=
ned!
>>=20
>>=20
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>> drivers/pwm/Kconfig | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> NAK given the discussion in the other thread.
>=20
> Thierry

OK, thanks, and I shall continue focusing the other thread, and send re=
lated patch after
get conclusion (hope I can finish within this week).

Thanks
=E2=80=94
Chen Gang
Open share, and attitude like air water, and life which God blessed.