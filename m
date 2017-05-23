From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH] pwm: silently error on EPROBE_DEFER
Date: Tue, 23 May 2017 19:37:34 +0200
Message-ID: <022f830b-2c43-c31c-9b03-eb36919045ca@suse.de>
References: <20170523160503.16920-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40589 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935795AbdEWRhh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 23 May 2017 13:37:37 -0400
In-Reply-To: <20170523160503.16920-1-jbrunet@baylibre.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Am 23.05.2017 um 18:05 schrieb Jerome Brunet:
> In of_pwm_chip, if we fail to get the pwm chip due to probe defer, we
> shouldn't print an error message. Just be silent in this case.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Andreas Färber <afaerber@suse.de>

Those messages are indeed irritating.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
