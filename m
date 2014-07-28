From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] pwm: add this patch to support the new pwm of
 Rockchip SoCs
Date: Mon, 28 Jul 2014 09:58:22 -0700
Message-ID: <CAOesGMgPDOQ0Z5b+d8nCiT4q_OGcYfv0zCb1naZVAqapaOtnPw@mail.gmail.com>
References: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com>
	<1405774529-26027-3-git-send-email-caesar.wang@rock-chips.com>
	<20140721085001.GG8843@ulmo>
	<53CD0E82.6030901@rock-chips.com>
	<20140721132723.GH15238@ulmo>
	<53D23192.4000908@rock-chips.com>
	<CAD=FV=XLjYQYmHxp3HBdwVmt6Wa7y-LEnsFKobsgVfFCp2-rRg@mail.gmail.com>
	<53D50601.1020106@rock-chips.com>
	<CAD=FV=UvF58NiY76FMi-TPVzsaWRJsR-M5HnHc7MRAWjwjY1jw@mail.gmail.com>
	<53D631B6.1050603@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53D631B6.1050603-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: caesar <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 28, 2014 at 4:19 AM, caesar <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wr=
ote:
> Doug,
> =E5=9C=A8 2014=E5=B9=B407=E6=9C=8828=E6=97=A5 12:01, Doug Anderson =E5=
=86=99=E9=81=93:
>
>> Caesar,
>>
>> On Sun, Jul 27, 2014 at 7:00 AM, caesar <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> wrote:
>>>
>>> /*I think will be show the faill log:->
>>>
>>> * rockchip-pwm ff9301a0.pwm: can't request region for resource [mem
>>> 0xff9301a0-0xff93019f]
>>> */
>>>
>>> pc->base =3D devm_ioremap_resource(dev, regs);
>>
>> Did you actually code this up and try it and get this error?
>
> Yeah.
>
>> I hadn't
>> tried it but I researched other dts files and it looked as if there
>> was one example that was doing this.  ...but perhaps it wasn't
>> actually doing the ioremap_resource on both ranges.
>>
>> I'd imagine that this is _probably_ equivalent to what Thierry was
>> suggesting, so if it didn't work then maybe Thierry's won't work
>> either?
>>
>> I don't have any other great suggestions other than doing two memory
>> ranges for lcdc:
>>
>>           lcdc@ff930000 {
>>                   compatible =3D "rockchip,rk3288-lcdc";
>>                   reg =3D <0xff930000 0x1a0>, <0xff9301b0 0xfe50>;
>>                   ...
>>           };
>>           pwm@ff9301a0 {
>>                   compatible =3D "rockchip,vop-pwm";
>>                   reg =3D <0xff9301a0 0x10>;
>>                   ...
>>           };
>>
>> ...but I am certainly nowhere near an expert on this stuff...
>>
>> -Doug
>>
>>
>>
> I has solve in lcdc driver,but I always feel awkward. I think a good =
way to
> solve in pwm driver.
> Unfortunately that  so far ,I have not a good idle in pwm driver.
>
> Maybe,I  let do it that way in lcdc driver.

I think there's an easier way to do this, by not focusing _too_ much
on the device tree:

* Define a platform_data structure for the PWM driver, which contains
readl/writel accessors as well as the device type (i.e. what you use
the compatible field and the lookup table for today).
* Populate the platform_device in the clcd driver, and register that
* Make the PWM driver probe as a regular platform device if pdata is pa=
ssed
* Make a readl/writel wrapper that either falls back to native
readl/writel when there aren't any passed in, or make the DT code fill
in the pdata with the native versions in that case.

Going full MFD on this seems overkill, unless there is also a shared
interrupt that needs to be handled.

-Olof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
