From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: Re: pwm: Introduce the pwm_args concept regression
Date: Tue, 17 May 2016 17:55:59 +0300
Message-ID: <573B30FF.4070504@nextfour.com>
References: <573AAEAF.5040603@nextfour.com>
 <20160517103151.54d1b413@bbrezillon> <573AE8E3.2070500@nextfour.com>
 <20160517121632.102f7bbd@bbrezillon> <20160517120523.GC26166@ulmo.ba.sec>
 <573B1985.6010006@nextfour.com> <573B2025.3070408@nextfour.com>
 <20160517161731.0e1d7949@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-am1on0090.outbound.protection.outlook.com ([157.56.112.90]:13812
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751317AbcEQPLF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 17 May 2016 11:11:05 -0400
In-Reply-To: <20160517161731.0e1d7949@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, jingoohan1@gmail.com, linux-pwm@vger.kernel.org



On 17.05.2016 17:17, Boris Brezillon wrote:
> On Tue, 17 May 2016 16:44:05 +0300
> Mika Penttil=C3=A4 <mika.penttila@nextfour.com> wrote:
>
>> On 17.05.2016 16:15, Mika Penttil=C3=A4 wrote:
>>> On 17.05.2016 15:05, Thierry Reding wrote: =20
>>>> On Tue, May 17, 2016 at 12:16:32PM +0200, Boris Brezillon wrote: =20
>>>>> On Tue, 17 May 2016 12:48:19 +0300
>>>>> Mika Penttil=C3=A4 <mika.penttila@nextfour.com> wrote:
>>>>> =20
>>>>>> On 05/17/2016 11:31 AM, Boris Brezillon wrote: =20
>>>>>>> +Thierry
>>>>>>>
>>>>>>> Hi Mika,
>>>>>>>
>>>>>>> On Tue, 17 May 2016 08:39:59 +0300
>>>>>>> Mika Penttil=C3=A4 <mika.penttila@nextfour.com> wrote:
>>>>>>>    =20
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> commit e39c0df1be5a97e0910b09af1530bdf3de057a06, pwm: Introduc=
e the pwm_args concept
>>>>>>>> causes pwm backlight to fail on our imx6 based board. I suspec=
t it affects all pwm backlight setups.
>>>>>>>> With this reverted, everything works as normal.   =20
>>>>>>> Hm, just tried using a PWM backlight on an atmel board (at91sam=
a5d4ek),
>>>>>>> and after applying the following patch, it worked correctly (th=
at's actually
>>>>>>> a bug in the PWM driver: the HLCDC PWM device is configured wit=
h inversed
>>>>>>> polarity by default, and the driver was not taking that into ac=
count).
>>>>>>> I doubt you have the same problem here since your PWM device is=
 not
>>>>>>> supporting polarity configuration.
>>>>>>>
>>>>>>> Could you tell me more about this bug? What are the symptoms? W=
hich
>>>>>>> board are you testing on (if it's not mainlined, can you share =
your
>>>>>>> DT)?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Boris
>>>>>>>
>>>>>>> ---
>>>>>>> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-at=
mel-hlcdc.c
>>>>>>> index f994c7e..14fc011 100644
>>>>>>> --- a/drivers/pwm/pwm-atmel-hlcdc.c
>>>>>>> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
>>>>>>> @@ -272,7 +272,7 @@ static int atmel_hlcdc_pwm_probe(struct pla=
tform_device *pdev)
>>>>>>>         chip->chip.of_pwm_n_cells =3D 3;
>>>>>>>         chip->chip.can_sleep =3D 1;
>>>>>>> =20
>>>>>>> -       ret =3D pwmchip_add(&chip->chip);
>>>>>>> +       ret =3D pwmchip_add_with_polarity(&chip->chip, PWM_POLA=
RITY_INVERSED);
>>>>>>>         if (ret) {
>>>>>>>                 clk_disable_unprepare(hlcdc->periph_clk);
>>>>>>>                 return ret;
>>>>>>>    =20
>>>>>> Symptom is entirely dark screen.
>>>>>> The board is not mainlined but the backlight part is defined lik=
e :=20
>>>>>>
>>>>>>   backlight: backlight {
>>>>>>                 compatible =3D "pwm-backlight";
>>>>>>                 pwms =3D <&pwm2 0 1000000 PWM_POLARITY_INVERTED>=
;
>>>>>>                 /*
>>>>>>                  * a poor man's way to create a 1:1 relationship=
 between
>>>>>>                  * the PWM value and the actual duty cycle
>>>>>>                  */
>>>>>>                 brightness-levels =3D < 0  1  2  3  4  5  6  7  =
8  9
>>>>>>                                      10 11 12 13 14 15 16 17 18 =
19
>>>>>>                                      20 21 22 23 24 25 26 27 28 =
29
>>>>>>                                      30 31 32 33 34 35 36 37 38 =
39
>>>>>>                                      40 41 42 43 44 45 46 47 48 =
49
>>>>>>                                      50 51 52 53 54 55 56 57 58 =
59
>>>>>>                                      60 61 62 63 64 65 66 67 68 =
69
>>>>>>                                      70 71 72 73 74 75 76 77 78 =
79
>>>>>>                                      80 81 82 83 84 85 86 87 88 =
89
>>>>>>                                      90 91 92 93 94 95 96 97 98 =
99 =20
>>>>>>                                     100>;   =20
>>>>>>                 default-brightness-level =3D <50>;
>>>>>>         };
>>>>>>
>>>>>>
>>>>>> so the polarity is in there defined.
>>>>>> The call call graphs is like : devm_pwm_get() -> pwm_get() -> of=
_pwm_get()  =20
>>>>>> -> of_pwm_xlate_with_flags which used to call pwm_set_period and=
 pwm_set_polarity but now   =20
>>>>>> just update the struct values. =20
>>>> Adding the linux-pwm mailing list on Cc for archiving.
>>>>
>>>> Do you have any local modifications? of_pwm_xlate_with_flags() is =
only
>>>> used if explicitly set up by the PWM driver and those that explici=
tly do
>>>> so are:
>>>>
>>>> 	$ git grep -n '=3D.*of_pwm_xlate_with_flags' -- drivers/pwm/
>>>> 	drivers/pwm/pwm-atmel-hlcdc.c:271:      chip->chip.of_xlate =3D o=
f_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-atmel-tcb.c:397:        tcbpwm->chip.of_xlate =3D=
 of_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-atmel.c:378:            atmel_pwm->chip.of_xlate =
=3D of_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-bcm-kona.c:277: kp->chip.of_xlate =3D of_pwm_xlat=
e_with_flags;
>>>> 	drivers/pwm/pwm-berlin.c:181:   pwm->chip.of_xlate =3D of_pwm_xla=
te_with_flags;
>>>> 	drivers/pwm/pwm-fsl-ftm.c:445:  fpc->chip.of_xlate =3D of_pwm_xla=
te_with_flags;
>>>> 	drivers/pwm/pwm-lpc18xx-sct.c:383:      lpc18xx_pwm->chip.of_xlat=
e =3D of_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-omap-dmtimer.c:318:     omap->chip.of_xlate =3D o=
f_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-renesas-tpu.c:421:      tpu->chip.of_xlate =3D of=
_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-rockchip.c:269:         pc->chip.of_xlate =3D of_=
pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-samsung.c:517:          chip->chip.of_xlate =3D o=
f_pwm_xlate_with_flags;
>>>> 	drivers/pwm/pwm-sun4i.c:335:    pwm->chip.of_xlate =3D of_pwm_xla=
te_with_flags;
>>>> 	drivers/pwm/pwm-tiecap.c:229:   pc->chip.of_xlate =3D of_pwm_xlat=
e_with_flags;
>>>> 	drivers/pwm/pwm-tiehrpwm.c:460: pc->chip.of_xlate =3D of_pwm_xlat=
e_with_flags;
>>>> 	drivers/pwm/pwm-vt8500.c:219:   chip->chip.of_xlate =3D of_pwm_xl=
ate_with_flags;
>>>>
>>>> pwm-imx is not among them and since it doesn't set anything else i=
t
>>>> should be using of_pwm_simple_xlate(). Also, the pwm-backlight dri=
ver
>>>> now calls pwm_apply_args() so it should still end up calling
>>>> pwm_set_polarity().
>>>>
>>>> Can you paste the DT node that has the pwm2 label? I suspect it's =
the
>>>> one in arch/arm/boot/dts/imx6qdl.dtsi (or something similar). That=
 node
>>>> has #pwm-cells =3D <2>, so providing the polarity in a third cell =
is not
>>>> correct. The PWM core /should/ be able to deal with it correctly, =
but I
>>>> think it might be worth correcting the DTS. There are a bunch of o=
ther
>>>> DTS files that contain the same mistake.
>>>>
>>>> If that doesn't help, perhaps you can attach dmesg output to help =
debug
>>>> this further? The PWM core is fairly silent, though, so you might =
need
>>>> to add some debugging messages in order to be able to see anything=
=2E I'm
>>>> thinking a first step would be to make sure all of the driver call=
backs
>>>> get called in the sequence that they should (and with the expected
>>>> parameters).
>>>>
>>>> Let me know if you need help with that.
>>>>
>>>> Thierry =20
>>> Yes you're right the pwm-cells is <2> and polarity in dts has no ef=
fect, and yes it
>>> uses pwm_simple_xlate of course. The polarity is ok, but something =
broke with this patch,
>>> looks like the pwm hw state is stuck to zero even when modified thr=
u /sys/class/backlight/backlight/brightness
>>> (the values in sysfs do change). I can debug this further tomorrow.
> Are you still testing on next or did you revert a few patches (like
> this one 3a0cfa4 "backlight: pwm_bl: Use pwm_get_args() where
> appropriate")?
> Maybe that would be easier if you could share the code you're testing
> with, can you push a branch somewhere?
>
Hmm I am testing against linus git (4.6.0+) and it doesnt have the "bac=
klight: pwm_bl: Use pwm_get_args()" yet pulled ? Maybe that explains...
It has "pwm: Introduce the pwm_args concept" so the tree is just broken=
 atm without the other parts?





=20
