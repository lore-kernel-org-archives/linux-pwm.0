From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Wed, 6 Feb 2019 15:54:50 +0100
Message-ID: <ddb93754-2734-e4c2-a209-517984c6d814@st.com>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
 <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
 <20190206125545.GI21676@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206125545.GI21676@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com, Tomasz Duszynski <tduszyns@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On 2/6/19 1:55 PM, Thierry Reding wrote:
> On Wed, Feb 06, 2019 at 09:54:05AM +0100, Uwe Kleine-König wrote:
>> On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
>>> If you agree with the current approach, I can send a V2 with Tomasz's
>>> suggestion to remove the ifdefs and use __maybe_unused instead.
>>
>> I think the suspend callback should have something like:
>>
>> 	if (is_still_enabled) {
>> 		/*
>> 		 * The consumer didn't stop us, so refuse to suspend.
>> 		 */
>> 		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
>> 		return -EBUSY;
>> 	}
>>
>> This way there are no bad surprises if the pwm is suspended before its
>> consumer and it's obvious what is missing.

Thierry, Uwe,

When the pwm is suspended before its consumer, the bad surprise is the
suspend request will fail... I'm not sure a new attempt may be better.
So, it looks like the only way to have this clean is by implementing the
device link e.g. via pwm_get() ?

> 
> Something that just occurred to me: perhaps as part of pwm_get() we
> should track where we were being requested from so that we could give
> hints in situations like this as to where the consumer is that forgot
> to suspend the PWM.

The current approach handles the situation where the consumer forgot to
suspend the PWM... I can add some warning about that in the suspend
routine, incl the label.

What do you think? What's the best approach ?

Please advise,
BR,
Fabrice
> 
> I suppose we already have pwm_device.label to help with this, but
> perhaps we could improve things if we stored __builtin_return_address
> during pwm_get() to help users pinpoint where they need to look.
> 
> Thierry
> 
