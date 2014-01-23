From: Milo Kim <milo.kim@ti.com>
Subject: Re: [PATCH] pwm: lp3943: Fix potential memory leak during request
Date: Fri, 24 Jan 2014 07:47:34 +0900
Message-ID: <52E19C06.1060003@ti.com>
References: <20140123223220.7d68b5f6@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48829 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbaAWWrl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 23 Jan 2014 17:47:41 -0500
In-Reply-To: <20140123223220.7d68b5f6@spike>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On 01/24/2014 06:32 AM, Christian Engelmayer wrote:
> Fix a memory leak in the lp3943_pwm_request_map() error handling path.
> Make sure already allocated pwm map memory is freed correctly.
> Detected by Coverity: CID 1162829.
>
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>

Acked-by: Milo Kim <milo.kim@ti.com>

Thanks!
  Milo


