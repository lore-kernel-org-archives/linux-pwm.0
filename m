From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] pwm: samsung: Use MODULE_DEVICE_TABLE() to include OF
 modalias
Date: Thu, 14 May 2015 02:47:57 +0200
Message-ID: <5553F0BD.1000606@collabora.co.uk>
References: <1431563551-9461-1-git-send-email-javier.martinez@collabora.co.uk> <5553EE5F.7030105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:46288 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbbENAsD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 May 2015 20:48:03 -0400
In-Reply-To: <5553EE5F.7030105@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hello Krzysztof,

On 05/14/2015 02:37 AM, Krzysztof Kozlowski wrote:
> On 14.05.2015 09:32, Javier Martinez Canillas wrote:
>> If the pwm-samsung driver is built as a module, modalias information is
>> not filled so the module is not autoloaded. Use the MODULE_DEVICE_TABLE()
>> macro to export the OF device ID so the module contains that information.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> I think many other Maxim/S[25]M drivers for Samsung boards may also be
> affected... Probably they should also be updated.
>

Yeah, I detected these since I'm preparing a series to reduce the delta
between exynos_defconfig and multi_v7_defconfig. And found these issues
since current multi_v7 policy is to build as much as possible as a module.
 
I think is unfortunate how many drivers are not providing proper module
aliases information and so building them as a module is less useful since
user-space can't associate the module with the modalias uevents to autoload.

Anyway, I'll take a look for other drivers and see if I can post similar
patches but now at least all the peripherals in the Exynos5 Chromebooks
are working when their drivers are built as a module.

> Best regards,
> Krzysztof
> 

Best regards,
Javier
