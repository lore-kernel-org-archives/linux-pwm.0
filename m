From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v4] pwm:lpss: update pwm setting for Broxton
Date: Mon, 16 Nov 2015 13:44:15 +0200
Message-ID: <20151116114415.GA1604@lahna.fi.intel.com>
References: <1447672444-81184-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18640 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbbKPLoS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 16 Nov 2015 06:44:18 -0500
Content-Disposition: inline
In-Reply-To: <1447672444-81184-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com

On Mon, Nov 16, 2015 at 07:14:04PM +0800, Qipeng Zha wrote:
> For Broxton PWM controller, base unit is defined as 8bit integer
> and 14bit fraction, so need to update base unit setting to output
> wave with right frequency.
> 
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> 
> ---
> change in v4
>  fix one code style issue, exceed 80 characters.

And you created another...

> +	/* The equation is:
> +	 * base_unit = ((freq / c) * base_unit_range) + correction
> +	 */

... block comments look line this:

	/*
	 * The equation is:
	 * base_unit = ((freq / c) * base_unit_range) + correction
	 */

;-)

Apart from that,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
