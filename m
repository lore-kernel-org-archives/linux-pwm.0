From: hl <hl@rock-chips.com>
Subject: Re: [PATCH 2/2] backlight: pwm: Add backlight-boot-off property
Date: Thu, 26 Feb 2015 16:06:17 +0800
Message-ID: <54EED3F9.7030009@rock-chips.com>
References: <1424920366-7626-1-git-send-email-hl@rock-chips.com>	<1424921954-8621-1-git-send-email-hl@rock-chips.com> <CAEC9eQP-jFJpneinkjD_VDKi83+SiBE2rcwf2vm2ZmbHV-vdOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from va-smtp01.263.net ([54.88.144.211]:56073 "EHLO
	va-smtp01.263.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbbBZIGr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Feb 2015 03:06:47 -0500
In-Reply-To: <CAEC9eQP-jFJpneinkjD_VDKi83+SiBE2rcwf2vm2ZmbHV-vdOQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ajay kumar <ajaynumb@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-rockchip@lists.infradead.org


On 2015=E5=B9=B402=E6=9C=8826=E6=97=A5 13:47, Ajay kumar wrote:
> Hi Huang,
>
> On Thu, Feb 26, 2015 at 9:09 AM, huang lin <hl@rock-chips.com> wrote:
>> Add backlight-boot-off property, so we can keeping the
>> backlight disabled at boot until it is enabled implicitly
>> by a panel driver, or explicitly by userspace
>>
>> Signed-off-by: huang lin <hl@rock-chips.com>
>>
>> ---
>>
>>   drivers/video/backlight/pwm_bl.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backli=
ght/pwm_bl.c
>> index 3a145a6..dece351 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -319,6 +319,10 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>>          }
>>
>>          bl->props.brightness =3D data->dft_brightness;
>> +
>> +       if (of_find_property(pdev->dev.of_node, "backlight-boot-off"=
, NULL))
>> +               bl->props.power =3D FB_BLANK_POWERDOWN;
>> +
> You need to check this. Originally, Thierry proposed it.
> http://permalink.gmane.org/gmane.linux.drivers.devicetree/84604
I have applied Thierry patch , and it can work. I think it should be=20
merged, since i use three type of edp panels,
they have same issue: when the backlight probe, the panel will visual=20
glitches.

>
>>          backlight_update_status(bl);
>>
>>          platform_set_drvdata(pdev, bl);
>> --
>> 1.9.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-fbde=
v" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--=20
=E9=BB=84=E6=9E=97
=E7=A6=8F=E5=B7=9E=E7=91=9E=E8=8A=AF=E5=BE=AE=E7=94=B5=E5=AD=90=E6=9C=89=
=E9=99=90=E5=85=AC=E5=8F=B8
=46uzhou Rockchip Electronics Co.Ltd
=E7=A6=8F=E5=BB=BA=E7=9C=81=E7=A6=8F=E5=B7=9E=E5=B8=82=E9=93=9C=E7=9B=98=
=E8=B7=AF=E8=BD=AF=E4=BB=B6=E5=A4=A7=E9=81=9389=E5=8F=B7=E8=BD=AF=E4=BB=
=B6=E5=9B=ADA=E5=8C=BA21=E5=8F=B7=E6=A5=BC(350003)
Addr:No.21 Building, A District, No.89, software Boulevard Fuzhou, Fuji=
an,PRC
Email:hl@rock-chips.com
Tel:+86-591-83991906/07
 =20
***********************************************************************=
*****************
=E4=BF=9D=E5=AF=86=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=
=E4=BA=BA=E3=80=82=E8=8B=A5=E9=9D=9E=E8=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7
=E5=8B=BF=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=A8=E6=88=96=E6=8A=AB=
=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=
=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=B8=E4=B9=85=
=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E6=89=80=
=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C
=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=A4=8D=E9=82=AE=E4=BB=B6=E6=88=96=E5=85=B6=
=E4=BB=96=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=8A=E7=9F=A5=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E3=80=82=E7=A6=8F=E5=B7=9E=E7=91=9E=E8=8A=AF=E5=BE=AE=
=E7=94=B5=E5=AD=90=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E6=8B=A5=E6=9C=89=
=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=BF=A1=E6=81=AF=E7=9A=84=E8=91=97=E4=BD=9C=
=E6=9D=83=E5=8F=8A=E8=A7=A3=E9=87=8A
=E6=9D=83=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=BB=8F=
=E6=8E=88=E6=9D=83=E8=AE=B8=E5=8F=AF=E7=9A=84=E4=BE=B5=E6=9D=83=E8=A1=8C=
=E4=B8=BA=E3=80=82
 =20
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., L=
td .The contents
of this email and any attachments may contain information that is privi=
leged, confidential
and/or exempt from disclosure under applicable law and relevant NDA. If=
 you are not the
intended recipient, you are hereby notified that any disclosure, copyin=
g, distribution,
or use of the information is STRICTLY PROHIBITED. Please immediately co=
ntact the sender
as soon as possible and destroy the material in its entirety in any for=
mat. Thank you.
***********************************************************************=
*********

