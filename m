Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from uho.ysoft.cz ([81.19.3.130]:47059 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfCTPTw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 Mar 2019 11:19:52 -0400
References: <9e1828a2-e3ae-853b-6a1c-010d1aa2f670@gmail.com>
 <23dd220e-6929-502c-ae9f-9b6cc994985a@ysoft.com>
 <d350d6b0-841d-4331-9751-c128b6a86b6e@gmail.com>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <1a073c92-ff1c-f539-2732-fe1353cf5a72@ysoft.com>
Date: Wed, 20 Mar 2019 16:19:50 +0100
MIME-Version: 1.0
In-Reply-To: <d350d6b0-841d-4331-9751-c128b6a86b6e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: issue with (parent)class for exported channels in sysfs
To: bdv.integrator@gmail.com
Cc: gottfried.haider@gmail.com, thierry.reding@gmail.com, hsweeten@visionengravers.com, linux-pwm@vger.kernel.org

On 20. 03. 19 16:10, Bart De Vos wrote:
> Okay,
> 
> I saw in the meantime it has been solved in mainstream, and could easily backport that part.
> 
> but ...
> 
> Your mentioning on versions confuses me: I'm running 4.19.28, I would expect that commit 552c02e3e7cf is part of that.

My bad, git describe 552c02e3e7cf returned: v4.19-rc1-15-g552c02e3e7cf.

That does not mean it is in v4.19. It is actually fixed in v4.20.
Sorry for the confusion.

> Anyhow, issue solved, thanks for your quick reply.

You're welcome.
Michal
