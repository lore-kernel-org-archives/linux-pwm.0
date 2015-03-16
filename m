From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 16/35 linux-next] video: constify of_device_id array
Date: Mon, 16 Mar 2015 14:29:43 -0500
Message-ID: <55072F27.80003@tabi.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426533651-25586-1-git-send-email-fabf@skynet.be> <1426533651-25586-7-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533651-25586-7-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?windows-1252?Q?S=F6ren_Brink?= =?windows-1252?Q?mann?= <soren.brinkmann@xilinx.com>, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 03/16/2015 02:20 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick<fabf@skynet.be>

...

>   drivers/video/fbdev/fsl-diu-fb.c           | 2 +-

For this driver:

Acked-by: Timur Tabi <timur@tabi.org>
