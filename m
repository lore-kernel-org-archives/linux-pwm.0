From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] pwm: bcm2835: Support for polarity setting via DT
Date: Thu, 27 Jul 2017 11:26:48 +0200
Message-ID: <409552fa-06af-e1f2-73af-2a9136d06816@i2se.com>
References: <1499508838-20715-1-git-send-email-stefan.wahren@i2se.com>
 <1499508838-20715-3-git-send-email-stefan.wahren@i2se.com>
 <87pod8qli1.fsf@eliezer.anholt.net>
 <748942990.26302.1500572090339@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:58242 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0J1k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2017 05:27:40 -0400
In-Reply-To: <748942990.26302.1500572090339@email.1und1.de>
Content-Language: de-DE
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>

Am 20.07.2017 um 19:34 schrieb Stefan Wahren:
>
>> Eric Anholt <eric@anholt.net> hat am 10. Juli 2017 um 18:56 geschrieben:
>>
>>
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> This adds support for the third (optional) pwm cell to specify the
>>> polarity, which is needed by display backlights for example.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
> gentle ping to Thierry

ping ...
