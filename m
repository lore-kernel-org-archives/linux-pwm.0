From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v8 0/2] Imagination Technologies PWM support
Date: Fri, 30 Jan 2015 08:01:00 -0300
Message-ID: <54CB646C.7040705@imgtec.com>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com> <54BE3369.9000802@imgtec.com> <54CA6089.50505@imgtec.com> <20150130091832.GA16744@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130091832.GA16744@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andrew Bresticker <abrestic@chromium.org>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vladimir_zapolskiy@mentor.com
List-Id: linux-pwm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Thierry,

On 01/30/2015 06:18 AM, Thierry Reding wrote:
> On Thu, Jan 29, 2015 at 01:32:09PM -0300, Ezequiel Garcia wrote:
>> On 01/20/2015 07:52 AM, Ezequiel Garcia wrote:
>>> 
>>> 
>>> On 01/09/2015 02:54 PM, Ezequiel Garcia wrote:
>>>> A new round for the IMG PWM driver.
>>>> 
>>>> The IMG PWM controller is muxed with a PDM controller,
>>>> through a shared so-called periph register bit, which sets
>>>> the output as PWM or PDM. Because this register is not part
>>>> of the pin controller block, but rather PWM/PDM specific, and
>>>> because the register is also used to set the PDM value, it is
>>>> simpler to use a regmap-based syscon to deal with it.
>>>> 
>>>> This time, I'm removing the PDM driver from the submission
>>>> and submitting the PWM alone. The PDM was written as a misc
>>>> driver, but had some design issues, so for now I'm proposing
>>>> to merge the PWM only.
>>>> 
>>>> The series is based on v3.19-rc3. If at all possible I'd like
>>>> to see this merged for v3.20.
>>>> 
>>> 
>>> Thierry,
>>> 
>>> Any comments on this? Any chance we merge it in time for
>>> v3.20? It's -rc5 already and I've started to worry.
>>> 
>> 
>> Thierry,
>> 
>> I'm very sorry to be so bothering, but I got no news from you and
>> it's -rc6 already. I'd say I'll resend this series to Andrew
>> Morton, hoping we can merge this for v3.20.
>> 
>> Please let me know if you'll be able to pick this.
> 
> I can pick it up if you make up your mind about the license. The
> header comment says GPL v2 or later, but MODULE_LICENSE has "GPL
> v2", which does not include the "or later" part.
> 

License should be GPL v2, sorry about that. Need me to fix it and
resend or can you amend it before pushing this?

> Also you're making it especially difficult to build-test by not 
> providing even the basic bits of your SoC support first. All even 
> linux-next seems to have for the Pistachio SoC is the addition of
> a compatible string to the dw-mmc driver.
> 

Well, we've added COMPILE_TEST for precisely this reason, so you only
need to select COMPILE_TEST on any arch and you'll be able to build
test the driver.

> I'll take the PWM driver, but I'll assume that you'll eventually
> have more pieces available, in which case I'd appreciate a note so
> I can update my build scripts.
> 

If you can pick it, it would be great. I understand it's hard to
accept patches for drivers, when there's little testing possibilities.
But on the other side, isn't it a positive thing that a vendor is
pushing drivers this early?

Thanks a lot,
- -- 
Ezequiel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUy2RhAAoJEIOKbhOEIHKiWB0QAKc4h+YLjxLLa7y0/NfoEiqV
gwipBbrfO4leAB6RUiDOGil53Ir0Pxg87IbCHV5A0Gzxahv47GG41DYPVzbU3lHm
DGkGqyXDf0BNQqJkCXmDWV9/8pnjFfUMDlSrs15pxXTaRjZ7m6CrxCoZof5UVt91
4cmeDYHg4lr+YzT3oXuyiKFlrIRrT5heD3gfyL5IB9qQypR2KPnpDrCwMcmT6+ag
zI6sg6OAi8de7ZvSWEZSK7WkymhgduR9Rt0WRQBC3EKF2dCsUxhmZt14RJsDcpEK
LWn5z1FxImtJq8vWOq/E2F9AWtQ/o9gUeII2myNDaL2SIrVoggUP+yKV51J8bidl
G2HXU8NEIHCaqcKl5sdbeEbB4diXVqGJu+d9SOM2lrW2PlwWN63jgnGfyYc2RadH
60adajBgNjs9Ujfo5nFy+aYXJtJZk+4b1M0UMI+2qKV4G9PBfDrrpUMBRCRt8il4
A15lUoHTwTeLQp8m7YmNuoKLhLmeVrBgbzBagFLUZgpJs7TEYIWefrh/jos37n2s
aNlVW55c5CXDMDX9Bef4ar6Ch95TOxPqiED70e2/lNM0ckRzd7viQandUxquvc9q
mSWhSxYuT62/B6innSbuWLdifKtCsqX+QQIo2NBC3AB+NVybEmC89gB8jx+Py7pX
YS0wpCGXivYm3AIWhhyT
=qi1N
-----END PGP SIGNATURE-----
