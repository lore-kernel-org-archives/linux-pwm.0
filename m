From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: simplify error handling
Date: Mon, 11 Nov 2019 22:30:42 +0100
Message-ID: <8328c71e-0a9a-31f4-afb5-b4b1bf28b004@web.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
 <a7a4656d-98b4-6bbb-e389-fe7028a38f97@web.de>
 <20191111200800.7njfdz7w3offt6we@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111200800.7njfdz7w3offt6we@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

>> Do you really want to call the function =E2=80=9Cof_node_put=E2=80=9D a=
t two places now?
>
> Yes, this is in my eyes more sensible.

Thanks for this explanation.


> Either you have the expected path and the error path interwinded,
> and the error path interwinded,

This is also reasonable then.
This design approach provides the possibility to release a few resources
earlier before using additional functionality.


> or you have to duplicate some cleanup.

* This can be required.

* I imagine that specific software infrastructures can help to avoid
  such duplication, can't they?


> IMHO the latter variant is the one that is easier to understand and the
> one where it's less likely to oversee a needed cleanup.

I am curious on how the clarification will be continued.


>>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> =E2=80=A6
>>>  	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>>>  	if (!omap) {
>>> -		pdata->free(dm_timer);
>>> -		return -ENOMEM;
>>> +		ret =3D -ENOMEM;
>>> +		goto err_alloc_omap;
>>>  	}
>> =E2=80=A6
>>
>> I suggest to reconsider your label name selection according to
>> the Linux coding style.
>
> Documentation/process/coding-style.rst states: "Choose label names which
> say what the goto does or why the goto exists." So I'd say my names are
> perfectly fine.

The guidance from the example after this quotation might be still too ters=
e
so far, isn't it?


>>> @@ -339,13 +334,28 @@ static int pwm_omap_dmtimer_probe(struct platfor=
m_device *pdev)
>> =E2=80=A6
>>> +err_pwmchip_add:
>>> +
>>> +	/*
>>> +	 * *omap is allocated using devm_kzalloc,
>>> +	 * so no free necessary here
>>> +	 */
>>> +err_alloc_omap:
>>> +
>>> +	pdata->free(dm_timer);
>>
>> Would the use of the label =E2=80=9Cfree_dm_timer=E2=80=9D be more appr=
opriate?
>
> Either you name your labels after what the code at the label does
> (then "free_dm_timer" is good)

I got used to this approach.


> you name it after why you are here (and then err_alloc_omap is fine).

This choice can trigger special software design consequences.


> I prefer the latter style and then the label
> name always has to correspond to the action just above it (if any).
> That's why I grouped the "err_alloc_omap" label to a comment saying that
> *omap doesn't need to be freed.

I am also curious if any other contributors would like to share more
views around this choice.


>>> +put:
>>> +	of_node_put(timer);
>> =E2=80=A6
>>
>> Can the label =E2=80=9Cput_node=E2=80=9D be nicer?
>
> I agree that the label name is bad.

I find your agreement on this aspect interesting then.


> I kept the name here and after the 3rd patch the label names are consist=
ent.

Can such an evolution be questionable?

Regards,
Markus
