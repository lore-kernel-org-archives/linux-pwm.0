From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] pwm: sun4i: add NULL check on of_match_device() return
 value
Date: Mon, 10 Jul 2017 14:26:53 -0500
Message-ID: <20170710142653.Horde.xPW2YI8hhsgtwvWq3L181cm@gator4166.hostgator.com>
References: <20170707063939.GA20510@embeddedgus>
 <CAGb2v64vwrTX9=MR-pNZP3eSUQUDj9V=oxx8ef-DaxZVue-pHg@mail.gmail.com>
 <20170707093300.GD15652@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707093300.GD15652@ulmo.fritz.box>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pwm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi all,

Quoting Thierry Reding <thierry.reding@gmail.com>:

> On Fri, Jul 07, 2017 at 03:16:23PM +0800, Chen-Yu Tsai wrote:
>> On Fri, Jul 7, 2017 at 2:39 PM, Gustavo A. R. Silva
>> <garsilva@embeddedor.com> wrote:
>> > Check return value from call to of_match_device()
>> > in order to prevent a NULL pointer dereference.
>> >
>> > In case of NULL print error message and return -ENODEV
>> >
>> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> > ---
>> >  drivers/pwm/pwm-sun4i.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>> > index 1284ffa..295ca19 100644
>> > --- a/drivers/pwm/pwm-sun4i.c
>> > +++ b/drivers/pwm/pwm-sun4i.c
>> > @@ -321,6 +321,10 @@ static int sun4i_pwm_probe(struct  
>> platform_device *pdev)
>> >         const struct of_device_id *match;
>> >
>> >         match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
>>
>> AFAIK this simply can not and should not fail with a device tree
>> only driver with properly populated of_device_id tables.
>
> Technically this could happen if someone manually created the platform
> device. In that case the core will try to match by name if there is no
> device node to use for a match against the list of of_device_ids.
>
> In my opinion it's best to let things crash in this situation to make
> it really obvious that people have done something wrong.
>

I get it.

Thanks for clarifying.
--
Gustavo A. R. Silva
