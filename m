From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH v8 1/2] pwm: Imagination Technologies PWM DAC driver
Date: Wed, 21 Jan 2015 15:13:05 +0200
Message-ID: <54BFA5E1.9070201@mentor.com>
References: <1420826088-13113-1-git-send-email-ezequiel.garcia@imgtec.com> <1420826088-13113-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:45941 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbAUNNU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Jan 2015 08:13:20 -0500
In-Reply-To: <1420826088-13113-2-git-send-email-ezequiel.garcia@imgtec.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vladimir_zapolskiy@mentor.com, Naidu Tellapati <naidu.tellapati@gmail.com>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

Hi Ezequiel,

On 09.01.2015 19:54, Ezequiel Garcia wrote:
> From: Naidu Tellapati <naidu.tellapati@gmail.com>
> 
> The Pistachio SOC from Imagination Technologies includes a Pulse Width
> Modulation DAC which produces 1 to 4 digital bit-outputs which represent
> digital waveforms. These PWM outputs are primarily in charge of controlling
> backlight LED devices.
> 
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/pwm/Kconfig   |  13 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-img.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/pwm/pwm-img.c
> 

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

