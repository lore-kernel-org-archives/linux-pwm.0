From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] Periodic Output, Timestamped Input
Date: Wed, 29 Nov 2017 23:54:32 +0100
Message-ID: <CACRpkdabNMHgs_ywzrgSg-AgQL1wtQN8SaxuZtCruiXnfrXGQw@mail.gmail.com>
References: <87ineapo5w.fsf@linux.intel.com> <CACRpkdY+72nz9gK=kSESoNdM+xicx-rnpKNz-UbYZ+TFLUXpbA@mail.gmail.com>
 <87shcxw5n3.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <87shcxw5n3.fsf@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>, =?UTF-8?Q?Bartosz_Go=C5=82aszewski?= <bartekgola@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, linux-gpio@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 29, 2017 at 2:56 PM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
> Me:
>> For the other thing: timestamping of GPIO events, we already
>> support timestamps for userspace GPIOs, but all it does is use
>> the kernel time, see gpiolib.c:
>>
>> static irqreturn_t lineevent_irq_thread(int irq, void *p)
>> {
>>         struct lineevent_state *le = p;
>>         struct gpioevent_data ge;
>>         int ret, level;
>>
>>         ge.timestamp = ktime_get_real_ns();
>>         level = gpiod_get_value_cansleep(le->desc);
>
> this is running as a thread with interrupts enabled, AFAICT. This means
> this thread can be preempted at least on PREEMPT_RT kernels, so your
> timestamp can be wrong, right?

Yes, it can be off. What we should do to get i better is
something like what I did in:
drivers/iio/gyro/mpu3050-core.c

Here I have both a hard and a soft IRQ handler (fast/slow if
you like) and take the timestamp in the hard IRQ, then use
it in the thread.

This should be done identically in gpiolib to increase precision
in the general case.

I was thinking about it already when implementing it but it fell
out of my mind. I'm putting in on my TODO. (CC to bartosz
who might be interested, he's using these ABIs quite a bit.)

Yours,
Linus Walleij
