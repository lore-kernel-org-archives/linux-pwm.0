From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v2 2/2] pwm: add this patch to support the new pwm of
 Rockchip SoCs
Date: Tue, 29 Jul 2014 19:09:07 +0800
Message-ID: <53D780D3.8070603@rock-chips.com>
References: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com> <1405774529-26027-3-git-send-email-caesar.wang@rock-chips.com> <20140721085001.GG8843@ulmo> <53CD0E82.6030901@rock-chips.com> <20140721132723.GH15238@ulmo> <53D23192.4000908@rock-chips.com> <CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com> <53D50601.1020106@rock-chips.com> <CAD=FV=UvF58NiY76FMi-TPVzsaWRJsR-M5HnHc7MRAWjwjY1jw@mail.gmail.com> <53D631B6.1050603@rock-chips.com> <20140729102212.GB21182@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140729102212.GB21182@ulmo.nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Thierry,

=E5=9C=A8 2014=E5=B9=B407=E6=9C=8829=E6=97=A5 18:22, Thierry Reding =E5=
=86=99=E9=81=93:
> On Mon, Jul 28, 2014 at 07:19:18PM +0800, caesar wrote:
>> Doug,
>> =E5=9C=A8 2014=E5=B9=B407=E6=9C=8828=E6=97=A5 12:01, Doug Anderson =E5=
=86=99=E9=81=93:
>>> Caesar,
>>>
>>> On Sun, Jul 27, 2014 at 7:00 AM, caesar <caesar.wang@rock-chips.com=
> wrote:
>>>> /*I think will be show the faill log:->
>>>>
>>>> * rockchip-pwm ff9301a0.pwm: can't request region for resource [me=
m
>>>> 0xff9301a0-0xff93019f]
>>>> */
>>>>
>>>> pc->base =3D devm_ioremap_resource(dev, regs);
>>> Did you actually code this up and try it and get this error?
>> Yeah.
> This should work if you properly set up the PWM subregion as a child =
of
> the LCDC region, which is what MFD will do for you.
>
> Thierry
As you say,should this change be occured by lcdc driver and dts?

The PWM driver don't need do any changes?

