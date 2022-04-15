<?php
/**
 * @package     pkg_papermanager
 * @copyright   Copyright (C) 2014 - 2022. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE
 * @link        https://papermanager.github.io/
 */

defined('_JEXEC') or die;

use Joomla\CMS\Plugin\CMSPlugin;

/**
 * Plugin to enable loading Paper Manager publications into content (e.g. articles)
 * This uses the {loadpapers} syntax
 *
 * @since  0.0.1
 */
class PlgContentPaperManager extends CMSPlugin
{
	/**
	 * Plugin that loads Paper Manager publications within content
	 *
	 * @param   string   $context   The context of the content being passed to the plugin.
	 * @param   object   &$article  The article object.  Note $article->text is also available
	 * @param   mixed    &$params   The article params
	 * @param   integer  $page      The 'page' number
	 *
	 * @return  void
	 *
	 * @since   0.0.1
	 */
	public function onContentPrepare($context, &$article, &$params, $page = 0)
	{
		// Don't run this plugin when the content is being indexed
		if ($context === 'com_finder.indexer')
		{
			return;
		}

		// Simple performance check to determine whether bot should process further
		if (strpos($article->text, 'loadpapers') === false && strpos($article->text, 'loadpapers') === false)
		{
			return;
		}

		// TODO: ...
	}

	/**
	 * Loads and renders a Paper Manager paper list
	 *
	 * @param   array   $p_authors    The authors       1 | ... | n | any
	 * @param   array   $p_categories The categories    1 | ... | n | any
	 * @param   array   $p_years      The years         YYYY | any
	 * @param   array   $p_months     The months        1 | ... | 12 | any
	 * @param   string  $p_lab        Produced in lab?  1 | 2 | any
	 *
	 * @return  mixed
	 *
	 * @since   0.0.1
	 */
	protected function _load($p_authors, $p_categories, $p_years, $p_months, $p_lab)
	{
		// TODO: ...
	}
}
