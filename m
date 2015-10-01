From: Olliver Schinagl <oliver+list@schinagl.nl>
Subject: Re: [RFC] pwm: core: unsigned or signed ints for pwm_config
Date: Thu, 01 Oct 2015 20:46:43 +0200
Message-ID: <560D7F93.1030609@schinagl.nl>
References: <560A3B7F.30803@schinagl.nl> <20150929074552.GA3648@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:58003 "EHLO 7of9.schinagl.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbJASqu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 1 Oct 2015 14:46:50 -0400
In-Reply-To: <20150929074552.GA3648@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hey Thierry,

On 29-09-15 09:45, Thierry Reding wrote:
> On Tue, Sep 29, 2015 at 09:19:27AM +0200, Olliver Schinagl wrote:
>> Hey Thierry, list
>>
>> I'm going over the pwm core and notice that in the pwm header, duty_ns and
>> period_ns is internally stored as an unsigned int.
>>
>> struct pwm_device {
>>      const char *label;
>>      unsigned long flags;
>>      unsigned int hwpwm;
>>      unsigned int pwm;
>>      struct pwm_chip *chip;
>>      void *chip_data;
>>
>>      unsigned int period;
>>      unsigned int duty_cycle;
>>      enum pwm_polarity polarity;
>> };
>>
>> However, pwm_config takes signed ints
>> int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
>>
>> So digging a little deeper in the PWM core, I see that pwm_config dissallows
>> negative ints, so having them unsigned has no benefit (and technically is
>> illegal)
>>      if (!pwm  || duty_ns < 0|| period_ns= 0 || duty_ns > period_ns)
>>          return -EINVAL;
>>
>> and because (after the check) we cram the signed int into an unsigned one:
>>
>>      pwm->duty_cycle = duty_ns;
>>      pwm->period = period_ns;
>>
>> This could end up badly when using any unsigned int larger then INT_MAX and
>> thus ending up with a negative duty/period.
> I don't think this is problematic because we're rejecting negative input
> values and store the non-negative ones in an unsigned int, so we can
> never store anything that would overflow the internal representation.
>
>> I haven't checked deeper if this
>> is accounted for later, but would it be worth my time to convert all ints to
>> unsigned ints? Since negative period and duty cycles are really not possible
>> anyway?
> The reason for storing them as unsigned internally is precisely because
> they can never be negative. The reason why pwm_config() has plain ints
> is historic. It's always been on my TODO list to convert them over to a
> unsigned variant, but never high priority enough. It's also problematic
> because doing so needs to modify a public API and hence requires
> auditing all consumers and providers to make sure nothing breaks.
>
> I'm not sure if it's worth spending this effort now. Boris Brezillon
> posted patches a few weeks ago to introduce an "atomic" API and that's
> going to require updating all users anyway. The new API also uses the
> correct types, so any effort should probably go into testing and
> migrating to the new API.
Thanks for saving me from doing  alot of work herin ;)

Are Boris his patches merged in some dev tree of yours? I'm working on 
some pwm stuff too and would love to work 'with'.

Olliver
>
> Thierry
