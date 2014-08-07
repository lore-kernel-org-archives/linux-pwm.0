From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Thu, 07 Aug 2014 21:55:24 +0800
Message-ID: <53E3854C.9070005@rock-chips.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com> <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com> <20140807061842.GB17340@ulmo> <53E3795E.4080607@rock-chips.com> <20140807131443.GA1540@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:49167 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757435AbaHGNzb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Aug 2014 09:55:31 -0400
In-Reply-To: <20140807131443.GA1540@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: heiko@sntech.de, b.galvani@gmail.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, rdunlap@infradead.org, galak@codeaurora.org, cf@rock-chips.com, huangtao@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, cjf@rock-chips.com, hj@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Thierry,

=E5=9C=A8 2014=E5=B9=B408=E6=9C=8807=E6=97=A5 21:14, Thierry Reding =E5=
=86=99=E9=81=93:
> On Thu, Aug 07, 2014 at 09:04:30PM +0800, caesar wrote:
> [...]
>> As you say, I will rewrite the about if it's really need  do so it.
>> For example:
>>
>> static const struct rockchip_pwm_data pwm_data_v1 =3D {
>>      .regs =3D {
>>                  .duty =3D 0x04,
>>                  .period =3D 0x08,
>>                  .cntr =3D 0x00,
>>                  .ctrl =3D 0x0c,
>>      },
>>      .prescaler =3D 2,
>>      .set_enable =3D rockchip_pwm_set_enable_v1,
>> };
>>
>> static const struct rockchip_pwm_data pwm_data_v2 =3D {
>>      .regs =3D {
>>                  .duty =3D 0x08,
>>                  .period =3D 0x04,
>>                  .cntr =3D 0x00,
>>                  .ctrl =3D 0x0c,
>>      },
>>      .prescaler =3D 1,
>>      .set_enable =3D rockchip_pwm_set_enable_v2,
>> };
>>
>> static const struct rockchip_pwm_data pwm_data_vop =3D {
>>      .regs =3D {
>>                  .duty =3D 0x08,
>>                  .period =3D 0x04,
>>                  .cntr =3D 0x0c,
>>                  .ctrl =3D 0x00,
>>      },
>>      .prescaler =3D 1,
>>      .set_enable =3D rockchip_pwm_set_enable_v2,
>> };
>>
>> Is that right?
> Yes.
>
>>>> +	.set_enable =3D rockchip_pwm_set_enable_v2,
>>>> +};
>>> No need for the double indirection.
>> Sorry, I think is need if you mean a double indirection for ".set_en=
able".
> The "double indirection" was regarding the symbolic names for registe=
rs,
> not the .set_enable(). Sorry.
OK,I will fix the about in patch v5 tomorrow if no other problems,Thank=
s!
> Thierry


