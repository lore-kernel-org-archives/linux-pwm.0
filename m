Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34392 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJWXI5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 19:08:57 -0400
Date: Wed, 23 Oct 2019 16:08:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20191023230852.GB35946@dtor-ws>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-4-git-send-email-jeff@labundy.com>
 <20191023002254.GW35946@dtor-ws>
 <20191023012913.GA3233@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023012913.GA3233@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 3/8] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
To: Jeff LaBundy <jeff@labundy.com>
Cc: lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

On Tue, Oct 22, 2019 at 08:29:13PM -0500, Jeff LaBundy wrote:
> Hi Dmitry,
> 
> Thank you for your prompt review.
> 
> On Tue, Oct 22, 2019 at 05:22:54PM -0700, Dmitry Torokhov wrote:
> > Hi Jeff,
> > 
> > On Sun, Oct 20, 2019 at 11:11:18PM -0500, Jeff LaBundy wrote:
> > > +	/*
> > > +	 * Each frame contains at most one wheel event (up or down), in which
> > > +	 * case a full keystroke is emulated.
> > > +	 */
> > > +	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
> > > +		input_report_key(iqs62x_keys->input,
> > > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
> > > +				 0);
> > > +		input_sync(iqs62x_keys->input);
> > > +	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
> > > +		input_report_key(iqs62x_keys->input,
> > > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
> > > +				 0);
> > 
> > Not '1'?
> > 
> 
> We pick up the '1' in the first of the two for loops above so long as the wheel
> moved "enough." In this case (and this case only), a subsequent '0' is sent to
> emulate a full press/release cycle (2 * {EV_KEY + EV_SYN}) for wheel "ticks."
> 
> I will update the comment to say "...in which case a complementary release cycle
> is emulated." If I have misunderstood your concern, please let me know.

Ah, sorry, no, I misread the code.

Thanks.

-- 
Dmitry
