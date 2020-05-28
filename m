From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 2/4] pwm: jz4740: Enhance precision in calculation of duty cycle
Date: Thu, 28 May 2020 14:41:03 +0000
Message-ID: <20200528144103.BF7C12089D__7997.23470570228$1590676875$gmane$org@mail.kernel.org>
References: <20200527115225.10069-2-paul@crapouillou.net>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgE1OlE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 28 May 2020 10:41:04 -0400
In-Reply-To: <20200527115225.10069-2-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, stable@vger.kernel.orgstable@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: f6b8a5700057 ("pwm: Add Ingenic JZ4740 support").

The bot has tested the following trees: v5.6.14, v5.4.42, v4.19.124, v4.14.181, v4.9.224, v4.4.224.

v5.6.14: Failed to apply! Possible dependencies:
    485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")
    ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

v5.4.42: Failed to apply! Possible dependencies:
    485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")
    ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

v4.19.124: Failed to apply! Possible dependencies:
    1ac99c58bda9 ("pwm: jz4740: Apply configuration atomically")
    485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")
    ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

v4.14.181: Failed to apply! Possible dependencies:
    174dcc8eaec5 ("pwm: jz4740: Implement ->set_polarity()")
    1ac99c58bda9 ("pwm: jz4740: Apply configuration atomically")
    485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")
    b419006275db ("pwm: jz4740: Enable for all Ingenic SoCs")
    ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

v4.9.224: Failed to apply! Possible dependencies:
    174dcc8eaec5 ("pwm: jz4740: Implement ->set_polarity()")
    1ac99c58bda9 ("pwm: jz4740: Apply configuration atomically")
    485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")
    b419006275db ("pwm: jz4740: Enable for all Ingenic SoCs")
    ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")

v4.4.224: Failed to apply! Possible dependencies:
    174dcc8eaec5 ("pwm: jz4740: Implement ->set_polarity()")
    1ac99c58bda9 ("pwm: jz4740: Apply configuration atomically")
    485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculation")
    b419006275db ("pwm: jz4740: Enable for all Ingenic SoCs")
    ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
