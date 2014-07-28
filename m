From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v2 2/2] pwm: add this patch to support the new pwm of
 Rockchip SoCs
Date: Mon, 28 Jul 2014 19:19:18 +0800
Message-ID: <53D631B6.1050603@rock-chips.com>
References: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com>	<1405774529-26027-3-git-send-email-caesar.wang@rock-chips.com>	<20140721085001.GG8843@ulmo>	<53CD0E82.6030901@rock-chips.com>	<20140721132723.GH15238@ulmo>	<53D23192.4000908@rock-chips.com>	<CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com>	<53D50601.1020106@rock-chips.com> <CAD=FV=UvF58NiY76FMi-TPVzsaWRJsR-M5HnHc7MRAWjwjY1jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:52350 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbaG1LTa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jul 2014 07:19:30 -0400
In-Reply-To: <CAD=FV=UvF58NiY76FMi-TPVzsaWRJsR-M5HnHc7MRAWjwjY1jw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Doug,
=E5=9C=A8 2014=E5=B9=B407=E6=9C=8828=E6=97=A5 12:01, Doug Anderson =E5=86=
=99=E9=81=93:
> Caesar,
>
> On Sun, Jul 27, 2014 at 7:00 AM, caesar <caesar.wang@rock-chips.com> =
wrote:
>> /*I think will be show the faill log:->
>>
>> * rockchip-pwm ff9301a0.pwm: can't request region for resource [mem
>> 0xff9301a0-0xff93019f]
>> */
>>
>> pc->base =3D devm_ioremap_resource(dev, regs);
> Did you actually code this up and try it and get this error?
Yeah.
> I hadn't
> tried it but I researched other dts files and it looked as if there
> was one example that was doing this.  ...but perhaps it wasn't
> actually doing the ioremap_resource on both ranges.
>
> I'd imagine that this is _probably_ equivalent to what Thierry was
> suggesting, so if it didn't work then maybe Thierry's won't work
> either?
>
> I don't have any other great suggestions other than doing two memory
> ranges for lcdc:
>
>           lcdc@ff930000 {
>                   compatible =3D "rockchip,rk3288-lcdc";
>                   reg =3D <0xff930000 0x1a0>, <0xff9301b0 0xfe50>;
>                   ...
>           };
>           pwm@ff9301a0 {
>                   compatible =3D "rockchip,vop-pwm";
>                   reg =3D <0xff9301a0 0x10>;
>                   ...
>           };
>
> ...but I am certainly nowhere near an expert on this stuff...
>
> -Doug
>
>
>
I has solve in lcdc driver,but I always feel awkward. I think a good wa=
y=20
to solve in pwm driver.
Unfortunately that  so far ,I have not a good idle in pwm driver.

Maybe,I  let do it that way in lcdc driver.


