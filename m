From: "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] pwm: remove set but not set variable 'pwm'
Date: Mon, 20 Jan 2020 19:40:37 +0800
Message-ID: <55871ad5-4cb0-f3c8-a408-2c1be894126a@huawei.com>
References: <20200119122202.14502-1-yukuai3@huawei.com>
 <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:9212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgATLku (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Jan 2020 06:40:50 -0500
In-Reply-To: <20200120073407.ck2fmk7qdvqsfqsy@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, zhengbin13@huawei.com, yi.zhang@huawei.com

On 2020/1/20 15:34, Uwe Kleine-König wrote:
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")

Thank you for your advise! I'll add 'Fixes' in a V2 patch.

> Did you check that dropping the locking is save? (I didn't)
> 
> I'd assume that no harm is introduced, but mentioning that in the commit
> log would be good.

I think dropping the lock is safe since there is nothing to be done
inside the lock. However, I didn't run a full test. By the way, I'll
mentioning it in a V2 patch.

Thanks!
Yu Kuai
