From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RFT] PWM: twl: actually disable twl6030 PWMs
Date: Thu, 8 May 2014 12:09:47 +0800
Message-ID: <CAFRkauBJ_LEEGiEo3jm76c_1qdx27yjbq+03KzKEh-TFH-14qg@mail.gmail.com>
References: <1397035286.1002.1.camel@phoenix>
	<534513AF.9030905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:57625 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbaEHEJs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 8 May 2014 00:09:48 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so2207502qcr.6
        for <linux-pwm@vger.kernel.org>; Wed, 07 May 2014 21:09:47 -0700 (PDT)
In-Reply-To: <534513AF.9030905@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

2014-04-09 17:32 GMT+08:00 Peter Ujfalusi <peter.ujfalusi@ti.com>:
> On 04/09/2014 12:21 PM, Axel Lin wrote:
>> Current twl6030_pwm_disable() implementation writes TWL6030_TOGGLE3_REG twice,
>> the second write sets TWL6030_PWMXEN bits so the PWM clock does not disable.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>> Hi Peter,
>> I don't have this h/w handy to test.
>> I'd appreciate if you can review and test this patch.
>
> You are right. The code was disabling the given PWM and then set the EN bit to
> one :o
> I don't have any explanation why it was like that, thanks for finding it!
>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi Thierry,
Would you pick up this patch?

Regards,
Axel
