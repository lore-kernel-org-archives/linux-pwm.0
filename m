From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 08/14] pwm: meson: add the per-channel register offsets
 and bits in a struct
Date: Tue, 28 May 2019 10:11:07 +0200
Message-ID: <b990a2da-8705-0579-14d0-c779f7aa70c5@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-9-martin.blumenstingl@googlemail.com>
 <7d169605-e117-70d4-5c66-47d2f80f4d4e@baylibre.com>
 <CAFBinCCyVHAG3yum_ty2dWXGaScafRcNPU-bHjxaKu9kzr8xQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCCyVHAG3yum_ty2dWXGaScafRcNPU-bHjxaKu9kzr8xQA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 27/05/2019 19:57, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, May 27, 2019 at 2:28 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> This looks a little over-engineered, but it's correct :
> my main motivation was to "not copy the 20 line switch/case statement
> from meson_pwm_enable() to meson_pwm_get_state()"
> I extended the idea that already existed for the "mux_reg_shifts"
> array and made it work for "more than one value"
> 
> please speak up if you have another idea in mind, maybe that makes the
> result even better

Sorry if I was misunderstood, your solution is correct, and I don't have any
simpler ideas in mind !

Neil

> 
> 
> Martin
> 
