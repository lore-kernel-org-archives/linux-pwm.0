From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v7 3/4] pdm: Imagination Technologies PDM DAC driver
Date: Thu, 8 Jan 2015 11:25:37 -0300
Message-ID: <54AE9361.80004@imgtec.com>
References: <1420651215-3836-1-git-send-email-ezequiel.garcia@imgtec.com>	<1420651215-3836-4-git-send-email-ezequiel.garcia@imgtec.com> <20150108142136.757eaeef@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150108142136.757eaeef@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, James Hartley <james.hartley@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Naidu Tellapati <Naidu.Tellapati@imgtec.com>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

On 01/08/2015 11:21 AM, One Thousand Gnomes wrote:
[..]
> 
> and - you get the idea 8)
> 

Thanks for all the comments. Before preparing a new patchset fixing
them, I'd like to check with the maintainers (Thierry on PWM, and Greg
on misc) about the validity of the general approach.

Thierry had concerns about the syscon usage, and I'd like to make sure
we settle that.

Guys, any feedback?

Thanks a lot!
-- 
Ezequiel
