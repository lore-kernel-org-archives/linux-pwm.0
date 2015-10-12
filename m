From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while
 requesting the PWM"
Date: Mon, 12 Oct 2015 15:39:46 +0300
Message-ID: <561BAA12.9060502@mentor.com>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
 <87bncjemdk.fsf@belgarion.home> <560CE816.1060307@atmel.com>
 <20151005093543.GB30219@ulmo> <20151005131912.4da38169@bbrezillon>
 <20151005125803.GA30025@ulmo> <20151005153024.3a245b0b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151005153024.3a245b0b@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 05.10.2015 16:30, Boris Brezillon wrote:
> On Mon, 5 Oct 2015 14:58:03 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
>> On Mon, Oct 05, 2015 at 01:19:12PM +0200, Boris Brezillon wrote:
>>> Hi Thierry,
>>>
>>> On Mon, 5 Oct 2015 11:35:43 +0200
>>> Thierry Reding <thierry.reding@gmail.com> wrote:
>>>
>>>> On Thu, Oct 01, 2015 at 10:00:22AM +0200, Nicolas Ferre wrote:
>>>>> Le 30/09/2015 21:29, Robert Jarzmik a =C3=A9crit :
>>>>>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>>>>>
>>>>>>> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
>>>>>>> This commit breaks legacy platforms, for which :
>>>>>>>  (a) no pwm table is added (legacy platforms)
>>>>>>>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and =
therefore
>>>>>>>      chosen =3D=3D NULL, and therefore pwm_get() returns NULL, =
and pwm_get()
>>>>>>>      returns -EPROBE_DEFER
>>>>>>>  (c) as a consequence, this code is unreachable in pwm_bl.c :
>>>>>>>      if (IS_ERR(pb->pwm)) {
>>>>>>> 	ret =3D PTR_ERR(pb->pwm);
>>>>>>>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret=
);
>>>>>>>  	if (ret =3D=3D -EPROBE_DEFER)
>>>>>>>  		goto err_alloc;
>>>>>>>
>>>>>>>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API=
\n");
>>>>>>>  	pb->legacy =3D true;
>>>>>>>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>>>>>>>
>>>>>>> As this code is unreachable, all legacy platforms relying on pw=
m_id are
>>>>>>> broken, amongst which pxa have been tested as broken.
>>>>>>>
>>>>>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>>>>> Thierry, would you have a look please ?
>>>>>> As I said before, all legacy platform relying on pwm_id are brok=
en. I'd like to
>>>>>> be sure this lands in the next -rc series.
>>>>>
>>>>> Well, as I answered on the linux-pwm mailing-list (I was not in c=
opy) here:
>>>>> http://article.gmane.org/gmane.linux.pwm/2744
>>>>> I wonder if it's not easier to fix the platforms and add the pwm =
tables...
>>>>>
>>>>> Otherwise, Boris proposed this fix:
>>>>> 8<-----------------------------------------------------------
>>>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
>>>>> index eff379b..00483d4 100644
>>>>> --- a/drivers/video/backlight/pwm_bl.c
>>>>> +++ b/drivers/video/backlight/pwm_bl.c
>>>>> @@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct platf=
orm_device *pdev)
>>>>>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>>>>>  	if (IS_ERR(pb->pwm)) {
>>>>>  		ret =3D PTR_ERR(pb->pwm);
>>>>> -		if (ret =3D=3D -EPROBE_DEFER)
>>>>> -			goto err_alloc;
>>>>> =20
>>>>>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\=
n");
>>>>>  		pb->legacy =3D true;
>>>>>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>>>>>  		if (IS_ERR(pb->pwm)) {
>>>>>  			dev_err(&pdev->dev, "unable to request legacy PWM\n");
>>>>> -			ret =3D PTR_ERR(pb->pwm);
>>>>> +			if (ret !=3D -EPROBE_DEFER)
>>>>> +				ret =3D PTR_ERR(pb->pwm);
>>>>> +
>>>>>  			goto err_alloc;
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> which is not tested and may add an extra non-valid error log.
>>>>
>>>> This is a little risky in my opinion. Not only does it print two e=
rror
>>>> messages for non-legacy platforms (that would be another regressio=
n if
>>>> you want to be nit-picking), but it is subtly buggy. If you have a
>>>> system with multiple PWM providers, you could end up failing the f=
irst
>>>> pwm_get() with -EPROBE_DEFER but then continue to the legacy case,=
 and
>>>> this could succeed because data->pwm_id =3D=3D 0, and that other p=
rovider
>>>> could be exporting the PWM with this ID. If I remember correctly t=
his
>>>> was one of the reasons why the offending commit was merged in the =
first
>>>> place.
>>>
>>> Just for the record, when I proposed this fix to Nicolas, I clearly
>>> stated that this was not the way to go, and that fixing the offendi=
ng
>>> platforms to use PWM lookup table was the only sane solution, thoug=
h I
>>> didn't thought about the invalid PWM id case leading to buggy behav=
ior.
>>
>> As chance would have it, this bubbled to the top of my inbox today:
>>
>> 	http://patchwork.ozlabs.org/patch/483993/
>=20
> AFAICT, this is not valid either. This patch is assuming -EPROBE_DEFE=
R
> can only be returned in the DT case, which is not the case:=20

=46YI at the time I've created and sent the change for review (Oct. 11,
2014 (!), https://patchwork.ozlabs.org/patch/398849/) there was no any
known to me intention to handle -EPROBE_DEFER .

Last week Lee mentioned that the patch does not apply due to added
-EPROBE_DEFER handling, so I've sent today to linux-pwm a rebased
version of the same change, which hopefully is acceptable, please take =
a
look.

> it is also returned if the PWMs were declared with a lookup table=20
> but the driver is not registered yet (module not loaded, or driver
> registration taking place after the PWM backlight driver).
>=20
> If we were about to differentiate the missing PWM definition from
> the missing driver case, we should do something like this [1].
>=20
> Best Regards,
>=20
> Boris
>=20
> [1]http://code.bulix.org/2oozbq-89125
>=20
>=20

--
With best wishes,
Vladimir
